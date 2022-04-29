Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41865147CD
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358117AbiD2LRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358116AbiD2LRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 07:17:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0889309;
        Fri, 29 Apr 2022 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wngx08weWCsGmrxDEzleetcbBBNl+025DlLgISUAOGs=; b=dQr3UDV5puAox9JOzqPeNILDHr
        Bmblwr9zthFLj9d5KYh+qi+eAMMaSAz3qdpNvMnFy/n9c1UrWiTYOIQpgWZnuQSfk+bQNmEv+LfKs
        mDBfH/QS5ylxcpTTIPr1sLCwyLVh8MyQLOF+g/0UZfwY/oEuXKx2LStP3PQCFCWAolzhTHqOvdHoE
        6KUiE0kGwciGYsyDy2YSHwgnLRQpFU2HjsRF9ToeyJmCuP3yVTXCPikU8w1Mkk1udmkJY3WELYn1k
        3Az12L1ZiM4tN8HyPfIh5uZ5KmNcSKNVtY5+XAHMmlhGzJImw/gt7pjxTJXYQaLdVtZVeuVeTUupP
        QcXgwJvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkOZB-00CLRn-FC; Fri, 29 Apr 2022 11:13:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A24593002B1;
        Fri, 29 Apr 2022 13:13:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8369520295B05; Fri, 29 Apr 2022 13:13:40 +0200 (CEST)
Date:   Fri, 29 Apr 2022 13:13:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        jpoimboe@redhat.com, ycote@redhat.com, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, davem@davemloft.net, ardb@kernel.org,
        maz@kernel.org, tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 25/37] arm64: bpf: Skip validation of
 ___bpf_prog_run
Message-ID: <YmvIZG5Ke6vElb/e@hirez.programming.kicks-ass.net>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-26-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429094355.122389-26-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 05:43:43PM +0800, Chen Zhongjin wrote:
> There is a jump table encoded in ___bpf_prog_run and objtool-arm64
> can't deal with it now. Skip validate it for arm64.

But, but, but, an earlier patch did -fno-jump-tables!

> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  kernel/bpf/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 13e9dbeeedf3..d702f1d83176 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2022,6 +2022,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  		BUG_ON(1);
>  		return 0;
>  }
> +#ifdef CONFIG_ARM64
> +STACK_FRAME_NON_STANDARD(___bpf_prog_run);
> +#endif
>  
>  #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
>  #define DEFINE_BPF_PROG_RUN(stack_size) \
> -- 
> 2.17.1
> 
