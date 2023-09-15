Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98CE7A1E89
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjIOMXF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjIOMXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 08:23:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA032D4C
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 05:22:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so255643366b.3
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694780542; x=1695385342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sgd0SQIzfDYqArl7ZJk837xYiiqp8Hlxo1eN43ivow=;
        b=ZXOHvqtR054spzQNdNa/BAv+K24FNOLN/bn869LKR2wEx/Q6epI1snO/JSpoiBYkjO
         9m8XbmaHxmJzW6grrqp2mP+EAxsYo42p8sH9yyGQusaIc9nfHdgTJoqekzrJhBJs6TPA
         v3reJRdlzchVQZnhOodlcyWH/at2Vaj5Uyyb59bW1fjTWYWUD7CNAKRMr2li1HlOBB9I
         2d+FdhBd5Hh9y8zkwLFY2vqmBZVYrMMSwl1AWEyZytvB7WWUdUwNGBn6S/CrfjRZXzdw
         5Z/BX08ZsXGFPw2VrSYoG6zdbfqvqT5NID/eReOHbGs1RyjDezTT7/vC4PIziJIKS2qw
         9ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780542; x=1695385342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sgd0SQIzfDYqArl7ZJk837xYiiqp8Hlxo1eN43ivow=;
        b=ACsiAvVtLAP6D9xEjyWVmgX1zKeQHoV/A10tlKVKjfpVHMiZiVL1S/KCC7F6MZMNNz
         1YLvnNtJlr4lMNoRoVNWO9Tm6EL6w4+o5DesHbwIxeEyYl+mRdwBftpc95Nma1N2i+ZF
         DwmKhu1e5oV9J8KJDYPlUXNhz4MzYIJPy/yv5ufrqsIOX32ZKdHPO+O5ZV4m+XhqTy6C
         qVw3xHcdJZQjtIVl7pNelJGKWRd+6MfCIpxn1GvsJjk0XhNCDSaJW205MY1vmfTLsd+J
         elKW0Vxl1U3OuFTjBL3bj399j+CXE0LL82AjkpYdm16kkZT4NhgVuIOPw3FWUF+QlVxq
         KI1A==
X-Gm-Message-State: AOJu0YwPTfxXHiudvUdX1j/FMczUp/P4c7rasoE2ep70XOiVxiqDgGet
        tN/S5f50Zq08fVOyWy7vvNg0sw==
X-Google-Smtp-Source: AGHT+IGQDixv4KWDUPWov7KbIiiYnnPGZejnzWBzk+C5wrXNyJ/XJxdD3iWD4oGpKAVkYFj5R24yJw==
X-Received: by 2002:a17:906:31d6:b0:9a1:c447:3c62 with SMTP id f22-20020a17090631d600b009a1c4473c62mr1220416ejf.49.1694780542706;
        Fri, 15 Sep 2023 05:22:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709067e4d00b009829dc0f2a0sm2330135ejr.111.2023.09.15.05.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:22:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:22:21 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Leonardo Bras <leobras@redhat.com>, guoren@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230915-1c2b122672642e2cbcbaaaef@orel>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-1ce4f391a14e56b456d88188@orel>
 <ZQQUQjOaAIc95GXP@redhat.com>
 <20230915-85238ac7734cf543bff3ddad@orel>
 <20230915-take-virus-1245c5dfed0a@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-take-virus-1245c5dfed0a@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 12:26:20PM +0100, Conor Dooley wrote:
> On Fri, Sep 15, 2023 at 01:07:40PM +0200, Andrew Jones wrote:
> > On Fri, Sep 15, 2023 at 05:22:26AM -0300, Leonardo Bras wrote:
> > > On Thu, Sep 14, 2023 at 03:47:59PM +0200, Andrew Jones wrote:
> > > > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > ...
> > > > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > > > > index 6960beb75f32..dc590d331894 100644
> > > > > --- a/arch/riscv/include/asm/insn-def.h
> > > > > +++ b/arch/riscv/include/asm/insn-def.h
> > > > > @@ -134,6 +134,7 @@
> > > > >  
> > > > >  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> > > > >  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> > > > > +#define RV_OPCODE_PREFETCH	RV_OPCODE(19)
> > > > 
> > > > This should be named RV_OPCODE_OP_IMM and be placed in
> > > > numerical order with the others, i.e. above SYSTEM.
> > > > 
> > > > >  
> > > > >  #define HFENCE_VVMA(vaddr, asid)				\
> > > > >  	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
> > > > > @@ -196,4 +197,8 @@
> > > > >  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> > > > >  	       RS1(base), SIMM12(4))
> > > > >  
> > > > > +#define CBO_prefetchw(base)					\
> > > > 
> > > > Please name this 'PREFETCH_w' and it should take an immediate parameter,
> > > > even if we intend to pass 0 for it.
> > > 
> > > It makes sense.
> > > 
> > > The mnemonic in the previously mentioned documentation is:
> > > 
> > > prefetch.w offset(base)
> > > 
> > > So yeah, makes sense to have both offset and base as parameters for 
> > > CBO_prefetchw (or PREFETCH_w, I have no strong preference).
> > 
> > I have a strong preference :-)
> > 
> > PREFETCH_w is consistent with the naming we already have for e.g.
> > cbo.clean, which is CBO_clean. The instruction we're picking a name
> > for now is prefetch.w, not cbo.prefetchw.
> 
> btw, the CBO_foo stuff was named that way as we were using them in
> alternatives originally as an argument, that manifested as:
> "cbo." __stringify(_op) " (a0)\n\t"
> That was later changed to
> CBO_##_op(a0)
> but the then un-needed (AFAICT) capitalisation was kept to avoid
> touching the callsites of the alternative. Maybe you remember better
> than I do drew, since the idea was yours & I forgot I even wrote that
> pattch.

And I forgot anything I may have suggested about it :-)

> If this isn't being used in a similar manner, then the w has no reason
> to be in the odd lowercase form.

Other than to be consistent... However, the CBO_* instructions are not
consistent with the rest of macros. If we don't need lowercase for any
reason, then my preference would be to bite the bullet and change all the
callsites of CBO_* macros and then introduce this new instruction as
PREFETCH_W

Thanks,
drew
