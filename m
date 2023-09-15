Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276BA7A1E37
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjIOMOu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjIOMOt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 08:14:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623B211E
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 05:14:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso2377320a12.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694780082; x=1695384882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szs0z99Qb90KUWcFs/6Ik8kAwcoyMXLC77ZFiHuCf3w=;
        b=PN/DFbN3DgFGIFvxXPGLIPBydhha7d+JZ/+dkvCkANB/401vidWXEa51pmtLhFzZEK
         drYOmTx7iO5Xw4XSmDFlGHZ3/aqgnitOTIwElnq8nskdDZieTy0aj5eUlWz1cKc5BNkZ
         S5C0OXxJyPCfkJJsdG5LxUB6w1sogjM/+zpdA3E0ErL5HG+hsOW9cmZ3/h88YsjMeIZr
         +M1g9UTUKlVrsHOCV7EcAZpDZwOTI2Wmd8f0UVQ7xOwSRH+YFeJY/LY54bml0I2M12YZ
         BsiTrX8+ys808Oa4N+n4WhWCu4RS5NKbxvPPqtqDFqe6+RjyyEbf4x1G/0szm0l5Li/0
         EvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780082; x=1695384882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szs0z99Qb90KUWcFs/6Ik8kAwcoyMXLC77ZFiHuCf3w=;
        b=MPLwuNvoicCR5r9CvqLUwzyj75EoUNxbH5JfticUkDAA4MRrHmIi74YC4uoBzqrj7t
         M2z/1AA5yskfmCSq2mgWG6sQC/EqLWj1QobsdfHo8n6fhmzhvRJNhuwSn8WzyIfC3uWC
         BfATqRvWde/NtoU9sd2/jEFyLkShep3Zb+BnJtLkiKrQDKz0J1kZOjM015z+0HyXjEBQ
         EEk+y0wHwvuXMAAvWzI/ZKmz86yatX5xw8rQBDkVvH8Ue8GpTZKESiVFP2ilRWrMzsKx
         tzUI0GQZ/Tgh6BcUQt34uDjJNM5Of+NYvS6Gx2qliXVPScPQXrPt9VIuBuStxuIiDUB+
         K5tA==
X-Gm-Message-State: AOJu0Yw/CSdFOnaCjtZtd2sQ+qSE3mlAPhTe5O6xUUT4eQOUwtuWGj1O
        D00Mdi3fc82LKEeBtl8YU7GNfw==
X-Google-Smtp-Source: AGHT+IGJZenyDQYnb3LjVAUFoWcYxvrgK5cLrtdOozPVvSraBAlkkM7GZOO5BDI5gIu6HsXU6mBNpQ==
X-Received: by 2002:aa7:d699:0:b0:522:30cc:a1f4 with SMTP id d25-20020aa7d699000000b0052230cca1f4mr1309802edr.0.1694780082187;
        Fri, 15 Sep 2023 05:14:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7d3c7000000b005233deb30aesm2196718edr.10.2023.09.15.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:14:41 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:14:40 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, leobras@redhat.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230915-ff4bd6cd721ed9bc4c4eb101@orel>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-892327a75b4b86badac5de02@orel>
 <20230914-74d0cf00633c199758ee3450@orel>
 <20230915-removing-flaky-44c66da669ae@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-removing-flaky-44c66da669ae@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 12:37:50PM +0100, Conor Dooley wrote:
> Yo,
> 
> On Thu, Sep 14, 2023 at 04:47:18PM +0200, Andrew Jones wrote:
> > On Thu, Sep 14, 2023 at 04:25:53PM +0200, Andrew Jones wrote:
> > > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > 
> > > > Cache-block prefetch instructions are HINTs to the hardware to
> > > > indicate that software intends to perform a particular type of
> > > > memory access in the near future. Enable ARCH_HAS_PREFETCHW and
> > > > improve the arch_xchg for qspinlock xchg_tail.
> > > > 
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/Kconfig                 | 15 +++++++++++++++
> > > >  arch/riscv/include/asm/cmpxchg.h   |  4 +++-
> > > >  arch/riscv/include/asm/hwcap.h     |  1 +
> > > >  arch/riscv/include/asm/insn-def.h  |  5 +++++
> > > >  arch/riscv/include/asm/processor.h | 13 +++++++++++++
> > > >  arch/riscv/kernel/cpufeature.c     |  1 +
> > > >  6 files changed, 38 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index e9ae6fa232c3..2c346fe169c1 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
> > > >  
> > > >  	   If you don't know what to do here, say Y.
> > > >  
> > > > +config RISCV_ISA_ZICBOP
> > > 
> > > Even if we're not concerned with looping over blocks yet, I think we
> > > should introduce zicbop block size DT parsing at the same time we bring
> > > zicbop support to the kernel (it's just more copy+paste from zicbom and
> > > zicboz). It's a bit annoying that the CMO spec doesn't state that block
> > > sizes should be the same for m/z/p. And, the fact that m/z/p are all
> > > separate extensions leads us to needing to parse block sizes for all
> > > three, despite the fact that in practice they'll probably be the same.
> > 
> > Although, I saw on a different mailing list that Andrei Warkentin
> > interpreted section 2.7 "Software Discovery" of the spec, which states
> > 
> > """
> > The initial set of CMO extensions requires the following information to be
> > discovered by software:
> > 
> > * The size of the cache block for management and prefetch instructions
> > * The size of the cache block for zero instructions
> > * CBIE support at each privilege level
> > 
> > Other general cache characteristics may also be specified in the discovery
> > mechanism.
> > """
> > 
> > as management and prefetch having the same block size and only zero
> > potentially having a different size. That looks like a reasonable
> > interpretation to me, too.
> 
> TBH, I don't really care what ambiguous wording the spec has used, we
> have the opportunity to make better decisions if we please. I hate the
> fact that the specs are often not abundantly clear about things like this.
> 
> > So, we could maybe proceed with assuming we
> > can use zicbom_block_size for prefetch, for now. If a platform comes along
> > that interpreted the spec differently, requiring prefetch block size to
> > be specified separately, then we'll cross that bridge when we get there.
> 
> That said, I think I suggested originally having the zicboz stuff default
> to the zicbom size too, so I'd be happy with prefetch stuff working
> exclusively that way until someone comes along looking for different sizes.
> The binding should be updated though since
> 
>   riscv,cbom-block-size:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description:
>       The blocksize in bytes for the Zicbom cache operations.
> 
> would no longer be a complete description.
> 
> While thinking about new wording though, it feels really clunky to describe
> it like:
> 	The block size in bytes for the Zicbom cache operations, Zicbop
> 	cache operations will default to this block size where not
> 	explicitly defined.
> 
> since there's then no way to actually define the block size if it is
> different. Unless you've got some magic wording, I'd rather document
> riscv,cbop-block-size, even if we are going to use riscv,cbom-block-size
> as the default.
>

Sounds good to me, but if it's documented, then we should probably
implement its parsing. Then, at that point, I wonder if it makes sense to
have the fallback at all, or if it's not better just to require all the
DTs to be explicit (even if redundant).

Thanks,
drew
