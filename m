Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B377703C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjHJGXy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 02:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJGXx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 02:23:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15010F5;
        Wed,  9 Aug 2023 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1691648628;
        bh=+TYDQF4gFd96ccfrWjufrvQOFIeyCG4Q5lehMbfQqog=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VZSvdTymJAcg2dhkhY6LCgYsVwsw9A5QrnKpL6dMKn7HNGZ6GWxfjRNQUN6ZDxzxV
         DPJpT8u2JghUGDAUE/u8DerstDePcocOZXK5c5gRR7Mxry3J9GOqU6wwp71+DIlMiU
         JNQr6Q6HPsGvVXNEuwrZfbnUKDK1ulIb/Fx+oEvAy49cJPDALhgOCLffbx1fHQs53Q
         zIE5adQjKK/70sfhrB/Swg2bneIF1RrGqhtjMrJCyALL46jg7H5uvDxUTTMRgemcIh
         8whjhcq/X7Y1S0KQ1qB54die4eM3UsFEN8J07EPwjkXyJUb2A15cDzEMAGRFjnFktN
         oyADssb8SVH6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLxhL5cHsz4wbP;
        Thu, 10 Aug 2023 16:23:46 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        rui.zhang@intel.com
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
In-Reply-To: <87tttoqxft.ffs@tglx>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <87tttoqxft.ffs@tglx>
Date:   Thu, 10 Aug 2023 16:23:46 +1000
Message-ID: <87msyzbekt.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Laurent, Michael!
>
> On Wed, Jul 05 2023 at 16:51, Laurent Dufour wrote:
>> I'm taking over the series Michael sent previously [1] which is smartly
>> reviewing the initial series I sent [2].  This series is addressing the
>> comments sent by Thomas and me on the Michael's one.
>
> Thanks for getting this into shape.
>
> I've merged it into:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
>
> and tagged it at patch 7 for consumption into the powerpc tree, so the
> powerpc specific changes can be applied there on top:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-for-ppc-23-07-28

Thanks. I've merged this and applied the powerpc patches on top.

I've left it sitting in my topic/cpu-smt branch for the build bots to
chew on:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/cpu-smt

I'll plan to merge it into my next in the next day or two.

cheers
