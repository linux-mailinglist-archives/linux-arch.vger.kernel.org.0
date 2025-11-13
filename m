Return-Path: <linux-arch+bounces-14734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AFEC58300
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 16:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19003A9855
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292561EE7DC;
	Thu, 13 Nov 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4cWUPBH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BA286D40
	for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045795; cv=none; b=KPfLp9YE16LGO29JF9K9b4xZ0Wpp6IjKqKNYURqwOYRJfeeMGLYqik7aNgPOUje9rbwsAt2OH4Zi6SdB4Caa0pFJ+4YhSmlt/4vURY+D8Rvlu77/Vt2WQC3HCwDzXUXQGtzc9I/t/JuVqZamcd+MOLSd7foKMMkMBER1r+EHnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045795; c=relaxed/simple;
	bh=LnaK991yb3KpzZBwHKDZk1oFyAzkHxiDUhEhGtuFbfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuJD8hYav/lFBsUhTY8S/1TGmTs5L/NJApFtM/XBhm1Po4MqEbmhCz0thSV3hIKsmEjp6Qr8Q3lvlKgLZYR9I6si/F0q3fY2ExhhvzTgP2BTeYc8NIh6M1Jx8kIEpo3e2vuGtNlO7d8SeoMzS1KwoyzU/3TPs6BVqsE04fs4Qnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4cWUPBH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edb8d6e98aso434261cf.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763045792; x=1763650592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOcv3Oj1S29dPcEyMLkkH0sbZM68IsUs9Y4Ns622AJg=;
        b=S4cWUPBHpEDRvgvrgQIAnqnG/Z6sDNHfujmVx3sEiYDuJIRpxGGRA/yR9+RIWDnJMh
         NgI5M52Ii/+UaUbl95+4e+fTgd/EoriQWTYLvm2j6qu4euwPQzN2ODWM9Sg312zfKmP+
         6GiI6Hp4eLfsW4OgAQ32He80iYguS+3Ncn6KF6xVDlRZOKmk/2Jk3lCvcqGtlpHj9LPr
         HV1SjEBKSula+R+BSiI3pGwlHyirl0hQ4j8pH2VQsNKGajyegJvwEGOCQj1dq9GMCpG2
         Y6hPxjpak3b4iR/PaZdWtrDtJsuCd/DMgdb4mQHpHwHL5Rhp370d5GvD8eTV0chsLrVQ
         c14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045792; x=1763650592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOcv3Oj1S29dPcEyMLkkH0sbZM68IsUs9Y4Ns622AJg=;
        b=jukFFj/Gmdxu02KkQ2t+cenoKsYCV8BBq3YEhLho1UxshPhZrko/bop/H/80+FqJas
         ao3cQdiV6ahd64r0ogn+xcoKJZxlkEB+w6xpBPo5EkzHWmTjtFxJCUzTj3KS0ShKptV4
         4w6y+JP6CBFY812fThENjxEbH90aYQ+JG6RO/5+ms1oV8ZeqFeOx/xIeIGLFQPWPn0eh
         NWWisvGpMeiZlR49oJogEUSurVbx9eXCVDw8H4EnPOxQ/+S02CVTlKOAAOgFQRhYlomp
         txb9AusJMRclYZAQ9Ck+pgvYmcto0Q97vCqV5/wuXdUtgJ8waDtbTt6yO2WaCVBb2fXZ
         3PLw==
X-Forwarded-Encrypted: i=1; AJvYcCXujbcYL7iYQuESLtDdw86JogxMoAfFnKEof4JKZKE14uUL4i1jgJMqwLFU/TTLoGp15GM7R7LxtGvU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4kKNKm8+jagiI9FGYeeWnPoqjFSn1W4kR911s7r6SEsMRUwi
	60xNMGTK+w0+yy2jv+sGOJGMm2KacQwrHC+xV7KYLt2RFLmvzuqJldE8P2mmPhgD1mxkKetHoJY
	LSulxoN+3rznEOzRYw0Cbe+P/o34NqVRRIrBwRbquc9AVqMI8Uy+B8qBHz7I=
X-Gm-Gg: ASbGnctbnFOx/L64xeofAu2sCDuF9aoj5t8xTj1+tUE1C00p8sKyT1qhxwhLvQ0+eT8
	LIKAXId7nifU0E/M0ZJbb4DIjsV3RVGvBMmMS13grorKHn+koTfNWDRWCX2CH/EQmZn+iPFWb96
	X3IpuMhf3MarKjRhyfb4AUtieI98kmf8x9UFZbhX/y4Dit6JyucuQ2dHEP84x40RP/LRNNRvDag
	+k0+DILcGvgjw5k831gnGal6hS69/iavPmPq8TeODLM1RZWhgWNs/Qn4TkpIhbpvn/zWgU=
X-Google-Smtp-Source: AGHT+IGogfC/SUDXpv1L77aGOFLKtzs4pnjU/Y+tNI7OLXUUULKozSgR4h/iI2FGD02gyPx7z2mu5aEd2kIo7q+p52o=
X-Received: by 2002:ac8:7d8a:0:b0:4b7:9c77:6ba5 with SMTP id
 d75a77b69052e-4ede8c6a598mr6532391cf.15.1763045792189; Thu, 13 Nov 2025
 06:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-2-lrizzo@google.com>
 <86o6p6t67m.wl-maz@kernel.org> <CAMOZA0K3hMSE32SnyVBW5NY4V=zuC3S7ueHfZN2sAWZNqRCwvQ@mail.gmail.com>
 <86jyzut2ni.wl-maz@kernel.org>
In-Reply-To: <86jyzut2ni.wl-maz@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 15:55:55 +0100
X-Gm-Features: AWmQ_bl5cDWnMypsBS7xTwuPq3dynzpoMRrEy__s7u5JeNmGvO4_npu6WhvgFqQ
Message-ID: <CAMOZA0+nKMvN_u7Di=2ODcMYgfyLXfHtvN1uDy3YdMR-kh5c1A@mail.gmail.com>
Subject: Re: [PATCH 1/6] genirq: platform wide interrupt moderation:
 Documentation, Kconfig, irq_desc
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 3:42=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
> [...]

>
> The descriptions are also massively x86-specific. That's probably OK
> for the stuff you care about, but I'd certainly would want things to
> be a bit more abstract and applicable to all architectures.

Absolutely.

> I also note that since you explicitly check for handle_edge_irq() in
> set_moderation_mode(), this will not work on anything GIC related, or
> any other architecture that uses the fasteoi flows. I really wonder
> why you are not looking at the actual trigger mode instead...

sure, that would be the best thing. Any suggestions on how to fix the
check ?

>
> Until you fix it, please refrain from touching the GICv3 code, and
> make sure this is solely enabled on x86 -- it clearly wasn't tested on
> anything else.

FWIW I did verify correct operation and performance boost on arm64,
both network and nvme (this was a previous version which
did not restrict to handle_edge_irq).

Also FWIW there should be nothing architecture-specific in this series.
The only reason I touched arch-specific code was to add initialization
of percpu structs, and that only because I had not found a better way
to run it before interrupts were activated.

Following Thomas' suggestion, this is now being replaced with
a more appropriate, architecture-independent code below

/* Per-CPU state initialization */
static void irq_moderation_percpu_init(void *data)
{
        struct irq_mod_state *ms =3D this_cpu_ptr(&irq_mod_state);

        hrtimer_setup(&ms->timer, moderation_timer_cb,
CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
        INIT_LIST_HEAD(&ms->descs);
}

static int cpuhp_setup_cb(uint cpu)
{
        irq_moderation_percpu_init(NULL);
        return 0;
}

static int __init init_irq_moderation(void)
{
        on_each_cpu(irq_moderation_percpu_init, NULL, 1);
        irq_mod_info.initialized =3D 1;
        cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
"moderation:online", cpuhp_setup_cb, NULL);
        proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops,
(void *)0);
        return 0;
}

cheers
luigi

