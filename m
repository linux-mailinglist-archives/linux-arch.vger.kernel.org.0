Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A787A1D1F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjIOLHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjIOLHu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 07:07:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441119F
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 04:07:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52e828ad46bso2385638a12.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694776061; x=1695380861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSTaAUWNZeJ+ndvekCOCXTKsKtVD+1FflqQrKtE2spY=;
        b=Tkt824TVhinfIutCsU7q+wl421ltfQFaBRc0FDXVbeNdxBbUcitLk2HIyLn6RucCDt
         Wk5FaFLeqMmqL3WWSZN2mVb9Nk9oAF6eu2QcvywZpx3Jkg0NvxhTUT8R0izfVvIDc0Lz
         YkEcjl9G/UxFsf/I1u+e53SMDwxchTlHN5kUyCnsjX3tE4sJWSr5BQF1spBMIvgHp1qm
         NzvGqJNNqOOViyaTLiuAfRS9gCrirVw/bCjYTbJIDC2zWpH/2dhT6bmu3SKO6Y4SA9lY
         k/QAAN1pBVQESI5+SJLa29zgq28u74awl8IgU1iAZEhYXQxGcHvvqmSZcXJFoOy2Wvbb
         txwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694776061; x=1695380861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSTaAUWNZeJ+ndvekCOCXTKsKtVD+1FflqQrKtE2spY=;
        b=w7ogO8oImvsOaEGamatPeWLkZula4VgAOVPeKBSbfGgtIoj0xaIiJo9ZKLeErGrJIM
         xxq7Sqq3U2nASfAKTqQMoEtPmjDWBdYvaxHC6Gw3DYsViDZEvY3QR/mqob3Ab95+Dq+t
         pxow7D8rhEsr0RC8aFOJeorxy6RVysOmQgpt4xRRoWwWRbhtZUresxIn4eUkO2lqREYv
         hkRbxY0LqhdjkDqPGpXK5Ug7PO0mKTH1/LWYtmKNYK2VUxLxzocSewpp3Esc+aFK6mdT
         /kApXQuwjDSDZDfcnpCi1UxR/d4IpxAxWZZ3sVQyn8QxqAfdYrfcoIfwc0Lg96odtS9G
         t++g==
X-Gm-Message-State: AOJu0YybUtmEex7sQsEOa7q0QSxFr4k/9kkGZXjnUF0QP2WAWjbWTkpz
        lQepzdiNJeOTycy/I4D0OVbeVg==
X-Google-Smtp-Source: AGHT+IGiV2IqFyocnUwP0Im2AbML69a4y/CuwGmjKXzDT8nO6Dk8Ye+9+SetD4JmUqgKSsACAavsSQ==
X-Received: by 2002:aa7:c2cb:0:b0:523:33d7:e324 with SMTP id m11-20020aa7c2cb000000b0052333d7e324mr1234271edp.38.1694776061469;
        Fri, 15 Sep 2023 04:07:41 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7c64a000000b0052c11951f4asm2075997edr.82.2023.09.15.04.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 04:07:40 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:07:40 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230915-85238ac7734cf543bff3ddad@orel>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-1ce4f391a14e56b456d88188@orel>
 <ZQQUQjOaAIc95GXP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQQUQjOaAIc95GXP@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 05:22:26AM -0300, Leonardo Bras wrote:
> On Thu, Sep 14, 2023 at 03:47:59PM +0200, Andrew Jones wrote:
> > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
...
> > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > > index 6960beb75f32..dc590d331894 100644
> > > --- a/arch/riscv/include/asm/insn-def.h
> > > +++ b/arch/riscv/include/asm/insn-def.h
> > > @@ -134,6 +134,7 @@
> > >  
> > >  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> > >  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> > > +#define RV_OPCODE_PREFETCH	RV_OPCODE(19)
> > 
> > This should be named RV_OPCODE_OP_IMM and be placed in
> > numerical order with the others, i.e. above SYSTEM.
> > 
> > >  
> > >  #define HFENCE_VVMA(vaddr, asid)				\
> > >  	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
> > > @@ -196,4 +197,8 @@
> > >  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> > >  	       RS1(base), SIMM12(4))
> > >  
> > > +#define CBO_prefetchw(base)					\
> > 
> > Please name this 'PREFETCH_w' and it should take an immediate parameter,
> > even if we intend to pass 0 for it.
> 
> It makes sense.
> 
> The mnemonic in the previously mentioned documentation is:
> 
> prefetch.w offset(base)
> 
> So yeah, makes sense to have both offset and base as parameters for 
> CBO_prefetchw (or PREFETCH_w, I have no strong preference).

I have a strong preference :-)

PREFETCH_w is consistent with the naming we already have for e.g.
cbo.clean, which is CBO_clean. The instruction we're picking a name
for now is prefetch.w, not cbo.prefetchw.

> 
> > 
> > > +	INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),		\
> > > +	       RD(x0), RS1(base), RS2(x0))
> > 
> > prefetch.w is not an R-type instruction, it's an S-type. While the bit
> > shifts are the same, the names are different. We need to add S-type
> > names while defining this instruction. 
> 
> That is correct, it is supposed to look like a store instruction (S-type), 
> even though documentation don't explicitly state that.
> 
> Even though it works fine with the R-type definition, code documentation 
> would be wrong, and future changes could break it.
> 
> > Then, this define would be
> > 
> >  #define PREFETCH_w(base, imm) \

I should have suggested 'offset' instead of 'imm' for the second parameter
name.

> >      INSN_S(OPCODE_OP_IMM, FUNC3(6), IMM_11_5(imm), __IMM_4_0(0), \
> >             RS1(base), __RS2(3))
> 
> s/OPCODE_OP_IMM/OPCODE_PREFETCH
> 0x4 vs 0x13

There's no major opcode named "PREFETCH" and the spec says that the major
opcode used for prefetch instructions is OP-IMM. That's why we want to
name this OPCODE_OP_IMM. I'm not sure where the 0x4 you're referring to
comes from. A 32-bit instruction has the lowest two bits set (figure 1.1
of the unpriv spec) and table 27.1 of the unpriv spec shows OP-IMM is
0b00100xx, so we have 0b0010011. Keeping the naming of the opcode macros
consistent with the spec also keeps them consistent with the .insn
directive where we could even use the names directly, i.e.

 .insn s OP_IMM, 6, x3, 0(a0)

> > 
> > When the assembler as insn_r I hope it will validate that

I meant insn_s here, which would be the macro for '.insn s'

> > (imm & 0xfe0) == imm

I played with it. It won't do what we want for prefetch, only
what works for s-type instructions in general, i.e. it allows
+/-2047 offsets and fails for everything else. That's good enough.
We can just mask off the low 5 bits here in our macro

 #define PREFETCH_w(base, offset) \
    INSN_S(OPCODE_OP_IMM, FUNC3(6), IMM_11_5((offset) & ~0x1f), \
           __IMM_4_0(0), RS1(base), __RS2(3))

Thanks,
drew
