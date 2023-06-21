Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC62737D0D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 10:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjFUHoe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUHod (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 03:44:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A610D;
        Wed, 21 Jun 2023 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XIUg3gDajjXx1L9B+6vEGFUgDSherxnnB+qfdlVJNWU=; b=P4wD/i70lrhaTSBrIAiJA1ZJw4
        Q6Q6jj7EaLa5t9YFa47VdKWDJfVTyYN3lQ0GXxuvHgEUZP0PWzJVNfKdnaFahJYDMSXhG8X2Odb47
        IEYEKArt2e4aY7U7kesU85LQpAKjdy484CGV92R8iAsWzNcL/oGQy8MmRoyYQi4EMKxH6VExImUAr
        T42Z/1JwMe5xnRb7wjg65ARU47dJMomPDfxxJrkdtta/lmPJ/5iyuHMpCWw5k4JG2izlKzW9XejsZ
        L3g4lEcetUs1uGuta7zyI3tfPv1wTYXeeTxVWCCKUBfUHRh69yyy9eghCAPLDPBq5pU8JRIYnmsUx
        P4K8pevA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBsVC-00HIVK-1L;
        Wed, 21 Jun 2023 07:43:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B475300222;
        Wed, 21 Jun 2023 09:43:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49482BD11718; Wed, 21 Jun 2023 09:43:37 +0200 (CEST)
Date:   Wed, 21 Jun 2023 09:43:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     mtosatti@redhat.com, ppandit@redhat.com, david@redhat.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, paulmck@kernel.org,
        frederic@kernel.org, will@kernel.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] send tlb_remove_table_smp_sync IPI only to
 necessary CPUs
Message-ID: <20230621074337.GF2046280@hirez.programming.kicks-ass.net>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620144618.125703-1-ypodemsk@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 20, 2023 at 05:46:16PM +0300, Yair Podemsky wrote:
> Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> indiscriminately, this causes unnecessary work and delays notable in
> real-time use-cases and isolated cpus.
> By limiting the IPI to only be sent to cpus referencing the effected
> mm.
> a config to differentiate architectures that support mm_cpumask from
> those that don't will allow safe usage of this feature.
> 
> changes from -v1:
> - Previous version included a patch to only send the IPI to CPU's with
> context_tracking in the kernel space, this was removed due to race 
> condition concerns.
> - for archs that do not maintain mm_cpumask the mask used should be
>  cpu_online_mask (Peter Zijlstra).
>  

Would it not be much better to fix the root cause? As per the last time,
there's patches that cure the thp abuse of this.
