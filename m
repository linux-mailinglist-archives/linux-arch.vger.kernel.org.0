Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6657A1682
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjIOGxQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjIOGxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 02:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 289AE2736
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694760734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mil5Lpt/AWqT9ucliicGrw0zms2aJ9EQRoMaWTOR9i0=;
        b=SV2hrhHvksiGOiy9I7WRaF35D2wblp2MAGwvZXJy8/e62OLxYDhjfnv34Domv7DnICanJx
        JxHeLzM/tk3Jxrc0h8nQe5qUt3KmW6pTiaV1CCbkAWpApE7vN36lUdoJ4n/7jkX550DDdo
        OBrRpKaJ5YLeV7R17TKY+W6v5vvJPbI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Hv_eEDmeO0iX_YqAZMxEcg-1; Fri, 15 Sep 2023 02:52:11 -0400
X-MC-Unique: Hv_eEDmeO0iX_YqAZMxEcg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c22d8a0cecso2164034a34.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 23:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760730; x=1695365530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mil5Lpt/AWqT9ucliicGrw0zms2aJ9EQRoMaWTOR9i0=;
        b=lsUXsN/CSNtfSEdHOIvs8+Wnqc/fNPJ/nEyWp2HAwcClhPqrQLqbkylTgu9SBDVh/X
         uq6Cw0rtSt2k8UakxTQu72TcFUDolejdqs9UxagEEWEU08BqLxsYAXy2eLs9DeU/Xq8F
         z0o0CKWrR4RZkEV6y2hyAG4qbVJtZghm3QZjNqsW2IPWZ0EdnkyjpZDS+/K3o0S+uJDG
         55podc7AL1Jtt5ipp/8OFXi5bojto/wc0yJOTP3Jc+wdVtVi5wSWmO3evqfce4b0l8md
         uB3+O8OAJtJOY4P6G/Wz3KOnustRPHHMIxUF5MeA5i6iWL1GyjUA8jO/gecxmhb3X5is
         pCGQ==
X-Gm-Message-State: AOJu0YxFrgBrQJM1wrx8lkuMHHbJH1WVp74OcGfUmx49LHcmnwjrIuxp
        capdds9soGh4qdJNP77TBUkkYbyZw4T4nUKeBfrD83OywzBG57rop70AVC+ekmLYD+oCiyQ9ZOq
        e79j8yiKDTn1toupA0Q2BDg==
X-Received: by 2002:a9d:61d2:0:b0:6b8:691e:ec53 with SMTP id h18-20020a9d61d2000000b006b8691eec53mr692074otk.11.1694760730710;
        Thu, 14 Sep 2023 23:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5XKtDZPdccOWeAcP3oR13oWpgp0h0NQCTbBcXsI+ozwyS91W+C45E6K0TtmaCpK+EoMojSA==
X-Received: by 2002:a9d:61d2:0:b0:6b8:691e:ec53 with SMTP id h18-20020a9d61d2000000b006b8691eec53mr692067otk.11.1694760730535;
        Thu, 14 Sep 2023 23:52:10 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id a9-20020a056830008900b006b9b6aea237sm1367919oto.80.2023.09.14.23.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:52:10 -0700 (PDT)
Date:   Fri, 15 Sep 2023 03:52:00 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 17/17] RISC-V: paravirt: pvqspinlock: KVM: Implement
 kvm_sbi_ext_pvlock_kick_cpu()
Message-ID: <ZQP_ELqR7y5recdD@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-18-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-18-guoren@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 04:29:11AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> We only need to call the kvm_vcpu_kick() and bring target_vcpu
> from the halt state. No irq raised, no other request, just a pure
> vcpu_kick.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kvm/vcpu_sbi_pvlock.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_pvlock.c b/arch/riscv/kvm/vcpu_sbi_pvlock.c
> index 544a456c5041..914fc58aedfe 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pvlock.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pvlock.c
> @@ -12,6 +12,24 @@
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_sbi.h>
>  
> +static int kvm_sbi_ext_pvlock_kick_cpu(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_vcpu *target;
> +
> +	target = kvm_get_vcpu_by_id(kvm, cp->a0);
> +	if (!target)
> +		return SBI_ERR_INVALID_PARAM;
> +
> +	kvm_vcpu_kick(target);
> +
> +	if (READ_ONCE(target->ready))
> +		kvm_vcpu_yield_to(target);
> +
> +	return SBI_SUCCESS;
> +}
> +
>  static int kvm_sbi_ext_pvlock_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  				      struct kvm_vcpu_sbi_return *retdata)
>  {
> @@ -21,6 +39,7 @@ static int kvm_sbi_ext_pvlock_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
>  
>  	switch (funcid) {
>  	case SBI_EXT_PVLOCK_KICK_CPU:
> +		ret = kvm_sbi_ext_pvlock_kick_cpu(vcpu);
>  		break;
>  	default:
>  		ret = SBI_ERR_NOT_SUPPORTED;
> -- 
> 2.36.1
> 


LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thanks!
Leo

