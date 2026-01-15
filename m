Return-Path: <linux-arch+bounces-15815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E1D2914F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 23:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85291301E6F9
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C8932C92B;
	Thu, 15 Jan 2026 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4O2oqvpg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556A32B9A5
	for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517096; cv=pass; b=ujrshzKqg2QCJaBM1e9zAW2VScDT9JaPlxr6+H8SburhjJbkJ9Lh2XvWo0q+1OMEpsq2McqPgKS0RC45ed+8huuloyaKI1mOv7FJSFQwwoFA5hEZzxrHLG6miyKWv5LlDYqS18YA0JRyJFNIeSzQxjlFJdjzzcVxjNM/Lfon5kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517096; c=relaxed/simple;
	bh=y91GI9V57RRoJzIiP91Znrtf9CBtKij5wRJxi0YQxfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/P9WmlfgIK46FUsNQUccSbsQ2Cf2ZSfhozEkpZXjtxGASFMG6oRecf9YIupM47OqQanYekwPahEitOzHoLMp9CvyvXDEwVoE6ccajJ9lsczcNDOOxMu/uHdK/oUYOJHlm4Vv2KX4bMC/l7eKIPHEEMBFeNarrJbhLmUb40t1o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4O2oqvpg; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014acad6f2so72651cf.1
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 14:44:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768517094; cv=none;
        d=google.com; s=arc-20240605;
        b=McV6eQ5cqWxxUBaJC7J86H4VZaqTs5myoAfsg6NZvKp+CQOMqDOdmzl7iIFVztZG20
         F/n3J6QbEIvWWRaqepy9M3rP4qoNXjkB0NkhQBita7Qy7T7ON2WCwso9Z8qu01KoLmyT
         b/HHfhQSCF69jZrBxiVbSktJjnR1+zc+BM8hnmwTnGjQ0hPvpIMqGLZ0H98hVac+ijXh
         dJTqzwQea0yGO0sScx+7w4RJCYXp9Y3I4EPqP3kU7z/atAUpfEiVgDnhh7FIG7VHydqh
         dED89Y9hz6Ff0MI3HeLzRy+plNzy6uG1RYy1TR/ntkT8nlWkYW9Y9SxST+NoqNfaF1aN
         1Hjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDpwulugom+CFgHkA/7OKl9DjzFinUAZIgC0jNi9Lcc=;
        fh=CohUGgK9jinUiFxr+n+b/pi3s1t/zSeeOEk6lI2mFCk=;
        b=EN9ohSKxz83wQhEGli96W770Gmwhqb7NG+Q05D0leYpeMtlAGTmE4OyCPwdZCou/SC
         0h824xdHyMjc4x1lYa6tZNOzQeKIEEXFImR59yHWGc3ys2qkQJ/TiSx4mbc1GWHNjg6Q
         SJI1SkFFFCilweh+7/EKgSMkZ0D2Q7ZlBkqtPIUZjjQoNKiUq19jZhU72DILbnuWTxkZ
         4vtrNfIx2SlNOb0io9xAPUzFzbpa+pYvNbXV70LWyNY5VX8edtauKG8p7TkPW6PUOkjG
         +OKEXdPcF88ahO6j0WnHCGirNF2OFGFAA+THtKFGAFsex7HK7A6ZK7I7qNDM60avLHqi
         MBqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768517094; x=1769121894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDpwulugom+CFgHkA/7OKl9DjzFinUAZIgC0jNi9Lcc=;
        b=4O2oqvpgeSWA2EPa9IvILpHLktbw+F/lFvVh6N4O8bRYWqrqZkrf+akuAWGueoVih/
         Fkj/UesKiNatC4DdY9/xlpCa+GlkNgn6zgnGoJ0TZw7vKDKEIBCVY9/s2CW42cAFtDX7
         SemO6owuuQgBY8myi22zjMDv9XN7nNPtrqeqyX03fmESrPNmyJNz921FELIIaLcqTSA6
         /PLYcWi2RDzULmdEfzPtwsLE/n+WyGO8vAL7YTWE36DEYiHorpZE76dw3MY1Y6pvX41g
         4gFazs5acbys0nx4Qtx118SaOkQCAAvQjY+ve9dbqr5fLD7TuQt6dvcxSYYXQECp4aeP
         Gd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517094; x=1769121894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDpwulugom+CFgHkA/7OKl9DjzFinUAZIgC0jNi9Lcc=;
        b=kGGpdPSntr38vmQghly8s7Tr1o9F22NGCZMrsz8JNdtzyLGFB7GR9HWmrPW8/ddZns
         AlGGD84Kj3XLz1veU5oktb3puwD7PuEUZx5rer5nYD+kyfoFVefz3LMI5xmSgWpLL0yc
         apY4Hu/ychV+FTNB0voEXF7ikn8p9BK63u/adGLt0sgysi8NynSgfW3A/3L3uLk9LVnY
         4QPKIZSnhh1D8f8ltzT8iGaMtB2PhqszGtMU1oBrQrxHE3s0dhOPL5/oT3b+sZ/P68xf
         K2/QBGlA2o34hdDz+RaLXM6hu0Q8SUk6OyyrnXcphzc59xXxqBD7yTTHFTP3VJP3/8+l
         Hz+A==
X-Forwarded-Encrypted: i=1; AJvYcCX6PdIEw53xlncuqQDe9FrMiloqmKyy+M39RXCxdzeAtVwOOA/kpUu67XFlsoUIDCQJz5rT+f2yoVp3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SBph6JzN2iuT6eu8YxxNkX4QSkj3uoFlRh24HUoOEq6fm99m
	psP/FmgfrESY2WqxaUt2wGYEILmNG9qeEXpjbwk+tgNnvWjNOyLALNLe5vsd+SWFX+ImPyuC4/X
	liJfi0WqYhEjFEsljnJ5Qq3vnMpbFXckp0BInhWC2
X-Gm-Gg: AY/fxX4tx/vrfco2/J+RfIvzJUVeDW92EH50nUR98AollMR/UXAAhdN1x+pAtjpvOA2
	Fvmqql5WB/XT5hEPLJU3muaa3x6+YMTapj4vYn1mtDywjZC0R9IHhF1j4Zzpf383HLXLpBfXuZm
	w68iYj11SoxRRQTqBboXitrLuvce8AiEJbdrYqUA9CtE3rWfsxSo+PMLTsru3i8zra6HliuukTt
	Y+d0LIpyn7rT8Qv10bMC4tnwjLxXTtd6et1IpRv/nrg6gewItuwlyjAvWM9cosLIhJk9F2h
X-Received: by 2002:ac8:7f4b:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-502a3753765mr1331471cf.19.1768517093809; Thu, 15 Jan 2026
 14:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115155942.482137-1-lrizzo@google.com> <20260115155942.482137-4-lrizzo@google.com>
 <87pl7a345y.ffs@tglx>
In-Reply-To: <87pl7a345y.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 15 Jan 2026 23:44:16 +0100
X-Gm-Features: AZwV_Qg-DVj5AdlsW7P455jeAFl-SG9P5qxpcRXuuLPe43vc0V_yci3V6LGctTY
Message-ID: <CAMOZA0+NSABcMEgmZxGwA2O9a-uhieLg+W3Q36KrhXKbkHiyNg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM).
To: Thomas Gleixner <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:24=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Thu, Jan 15 2026 at 15:59, Luigi Rizzo wrote:
> >  /* Initialize moderation state, used in desc_set_defaults() */
...
> Also this sequence count magic on the read side does not have any real
> value:
>
> > +     if (raw_read_seqcount(&irq_mod_info.seq.seqcount) !=3D m->seq) {
>
> Q: What's the gain of this sequence count magic?

The goal is stated in the comment just before the read, see text below.
Surely I can use your suggestion and have the procfs write callback update
all the per-cpu copies and avoid looking for the change on each CPU.

        /*
         * If any of the configuration parameter changes, read the main one=
s
         * (delay_ns, update_ns), and set the adaptive delay, mod_ns, to th=
e
         * maximum value to help converge.
         * Without that, the system might be already below target_intr_rate
         * because of saturation on the bus (the very problem GSIM is tryin=
g
         * to address) and that would block the control loop.
         * Setting mod_ns to the highest value (if chosen properly) can red=
uce
         * the interrupt rate below target_intr_rate and let the controller
         * gradually reach the target.
         */

cheers
luigi

