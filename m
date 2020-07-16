Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973B222B5C
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGPTAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPTAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:00:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48420C061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 12:00:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so5263438pjb.4
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JfJefRWjeb9DH1MrBUsvBscaMgupvBInX+3elN90M+E=;
        b=KnSzidzo66xdykVg2SLxktyn55MXR0V55tGOU4DaExdIhtIt3GeqanAb1iKPf9R7KE
         +2piaCrkav87qgcni5NLFfUDAKLxjdaJPx9WQJnAac+UYP6ESjs+6B8huzoSkq4mC2T3
         VUWb5deEwYeyRTHXqAK/Q+wDPKoivdAzPEnDP7MKYsI3tXH/rNF7N7r2+6M5zLpI5Ukp
         fnmBHBu9jGkYkc4McRpEiI3ISoIIvnA4QXAd8EFuUQROxCThFFTJaW2nb3DticgpBMGI
         qUkxoJJzHo097Q195B3t4fK4L83tbp2rQ3/Y5v0+xqURCSyJBlaw35OFl2xfIKTKYpzI
         W3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JfJefRWjeb9DH1MrBUsvBscaMgupvBInX+3elN90M+E=;
        b=kEkofioth3qxpCPpofT/7K0yGgLVJHIiM4lBiH8fKUWjCRtmehVAd1UnwvN6sPp+gJ
         4M+6NNwq0NY9iHb3ag14Gi6SGpjNNXfyT/Un+zUJTQ0VXFIVSZ9g8pDdw4h9nQ4bYRYM
         KRcxLsyt3tqXDVVam1oRmiGgC2s+3L1LDHA44NoQsq5GIrnrpUmdHJIhYBCmpb8k+wgv
         uBqgfljPhLOhOx6bOcAQZk+Awl+xGC6dtcm4R87NvtaJPGFij2zzvTCPbqm5pPvTZsLr
         CYqaovoRhiTmloeigx5H8xdWVuOIUdz+hE1l11CBmNRD80CYMHFqoAJuftDUwOAAPW/x
         AKSg==
X-Gm-Message-State: AOAM532DXfvjjH90CeMDKD5q5g/EVCX8t0Ngz5aUxYlBlDBxvnjavtY0
        3RJbqbziGWfS6RFh1WhhIgvBBQ==
X-Google-Smtp-Source: ABdhPJz6CJzyKeJCf96A5qLRYs4FcPz9lfbS3DVtPeqeYK5pu2QxyfXQvlIhSQOHGR+IIdSxznfGCQ==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr4595359plo.94.1594926002609;
        Thu, 16 Jul 2020 12:00:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u73sm5753263pfc.113.2020.07.16.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:00:01 -0700 (PDT)
Date:   Thu, 16 Jul 2020 12:00:01 -0700 (PDT)
X-Google-Original-Date: Thu, 16 Jul 2020 11:59:58 PDT (-0700)
Subject:     Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
CC:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        will@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>, guoren@kernel.org,
        mpe@ellerman.id.au
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     will@kernel.org
Message-ID: <mhng-6528b0ae-d92c-41b2-b0fd-3be58c80f280@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 16 Jul 2020 04:28:16 PDT (-0700), will@kernel.org wrote:
> Although mmiowb() is concerned only with serialising MMIO writes occuring
> in contexts where a spinlock is held, the call to mmiowb_set_pending()
> from the MMIO write accessors can occur in preemptible contexts, such
> as during driver probe() functions where ordering between CPUs is not
> usually a concern, assuming that the task migration path provides the
> necessary ordering guarantees.
>
> Unfortunately, the default implementation of mmiowb_set_pending() is not
> preempt-safe, as it makes use of a a per-cpu variable to track its
> internal state. This has been reported to generate the following splat
> on riscv:
>
>  | BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>  | caller is regmap_mmio_write32le+0x1c/0x46
>  | CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
>  | Call Trace:
>  |  walk_stackframe+0x0/0x7a
>  |  dump_stack+0x6e/0x88
>  |  regmap_mmio_write32le+0x18/0x46
>  |  check_preemption_disabled+0xa4/0xaa
>  |  regmap_mmio_write32le+0x18/0x46
>  |  regmap_mmio_write+0x26/0x44
>  |  regmap_write+0x28/0x48
>  |  sifive_gpio_probe+0xc0/0x1da
>
> Although it's possible to fix the driver in this case, other splats have
> been seen from other drivers, including the infamous 8250 UART, and so
> it's better to address this problem in the mmiowb core itself.
>
> Fix mmiowb_set_pending() by using the raw_cpu_ptr() to get at the mmiowb
> state and then only updating the 'mmiowb_pending' field if we are not
> preemptible (i.e. we have a non-zero nesting count).
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> I can queue this in the arm64 tree as a fix, as I already have some other
> fixes targetting -rc6.
>
>  include/asm-generic/mmiowb.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> index 9439ff037b2d..5698fca3bf56 100644
> --- a/include/asm-generic/mmiowb.h
> +++ b/include/asm-generic/mmiowb.h
> @@ -27,7 +27,7 @@
>  #include <asm/smp.h>
>
>  DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> -#define __mmiowb_state()	this_cpu_ptr(&__mmiowb_state)
> +#define __mmiowb_state()	raw_cpu_ptr(&__mmiowb_state)
>  #else
>  #define __mmiowb_state()	arch_mmiowb_state()
>  #endif	/* arch_mmiowb_state */
> @@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
>  static inline void mmiowb_set_pending(void)
>  {
>  	struct mmiowb_state *ms = __mmiowb_state();
> -	ms->mmiowb_pending = ms->nesting_count;
> +
> +	if (likely(ms->nesting_count))
> +		ms->mmiowb_pending = ms->nesting_count;
>  }
>
>  static inline void mmiowb_spin_lock(void)

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

The arm64 tree works for me.

Thanks!
