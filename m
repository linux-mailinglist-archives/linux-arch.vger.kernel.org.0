Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9121B73A0A2
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 14:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFVMO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjFVMO3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 08:14:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A7171C;
        Thu, 22 Jun 2023 05:14:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmznY1RHFz4x04;
        Thu, 22 Jun 2023 22:14:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1687436066;
        bh=VyK+T7wpYZieXhcDB/H+1KJ1YxNx6190VxkOIlmBktI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hnaboYieOfnnuNB8OHVEabPqrovQFXHSe6l2zxpfBrXLYGFjlm8ZAWrxhhS7y1Vap
         0LtUYWtUif9PeV4IJlza3hqmWjOAA6FDMPe82TRMsPXMHygXkmmy0nLi0PGTZogalO
         cP9U+cgif/Co9lGKBZO64O/wkTk9rYnW1J+5KH6+xnoZK/A3PZuzsOa0GtIffF+K87
         W/1TMd+p4WA6T31KCxfkPzYI0Qu7AOxq6j+d1yaoH8/0ZONecNmkI6LCOL+V3Bf/eG
         kxGSgTH5KZQ+wXxPjI98JWHeAJnyudGZqhd6tx1eq7I/kwj3q3rDhPob6NCpGP5NEV
         8nHc9uYWGeTrg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
        mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH 07/10] cpu/SMT: Allow enabling partial SMT states via sysfs
In-Reply-To: <87legb7tdz.ffs@tglx>
References: <20230615154635.13660-1-ldufour@linux.ibm.com>
 <20230615154635.13660-8-ldufour@linux.ibm.com> <87legb7tdz.ffs@tglx>
Date:   Thu, 22 Jun 2023 22:14:24 +1000
Message-ID: <87sfajofrz.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> On Thu, Jun 15 2023 at 17:46, Laurent Dufour wrote:
>>  
>> -	if (ctrlval != cpu_smt_control) {
>> +	orig_threads = cpu_smt_num_threads;
>> +	cpu_smt_num_threads = num_threads;
>> +
>> +	if (num_threads > orig_threads) {
>> +		ret = cpuhp_smt_enable();
>> +	} else if (num_threads < orig_threads) {
>> +		ret = cpuhp_smt_disable(ctrlval);
>> +	} else if (ctrlval != cpu_smt_control) {
>>  		switch (ctrlval) {
>>  		case CPU_SMT_ENABLED:
>>  			ret = cpuhp_smt_enable();
>
> This switch() is still as pointless as in the previous version.
>
> OFF -> ON, ON -> OFF, ON -> FORCE_OFF are covered by the num_threads
> comparisons.
>
> So the only case where (ctrlval != cpu_smt_control) is relevant is the
> OFF -> FORCE_OFF transition because in that case the number of threads
> is not changing.
>
>           force_off = ctrlval != cpu_smt_control && ctrval == CPU_SMT_FORCE_DISABLED;
>
> 	  if (num_threads > orig_threads)
> 		  ret = cpuhp_smt_enable();
> 	  else if (num_threads < orig_threads || force_off)
> 		  ret = cpuhp_smt_disable(ctrlval);
>
> Should just work, no?

Yes, I think so.

I'll fold that in and do a respin of this series for 6.6 in the next
week or two.

cheers
