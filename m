Return-Path: <linux-arch+bounces-12953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4FB11D53
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 13:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD225A2F26
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEE02E5B14;
	Fri, 25 Jul 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REO6xqKh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5F2E54CA;
	Fri, 25 Jul 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442085; cv=none; b=oxBz6n1By7bNlP0iPYNcBK+IjENozxKTW5I62fgK4IWlNnnXRlrgIeS8TP76I+Yi5XrTMErwn8CeT8fVy7SYnnIODLIiaL9SxnO3l6Z8pP72ACvCLcTKFFCV04M85qAFoG/q0QC89hF0UffX/ITdcxo/H7KTH69m+nVB1wAfLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442085; c=relaxed/simple;
	bh=ShnHV7JNrTopJF7AM7OfGbO3XWiG23k6eeCn8GuXIpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soUI5+EDksDlXczwwGTZcNdd4gFMzz6PFYj2geHC28v4sT4gYjbcpLQ4KlNAT0hIVxocaoQZszm5mS232zU1vLO6InqSdtefaFSZa1Qd6v5w6160temb8PZhEWXFwolcbU6YrUHhPrgW+a+ec8O6LrP1Qm8IfvY1MWAEY7cRyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REO6xqKh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234f17910d8so17242745ad.3;
        Fri, 25 Jul 2025 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753442083; x=1754046883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaiH/38WONPy8fzRyhRHdFQdB6YbrzolydS9CtzX8Do=;
        b=REO6xqKhPMwWEVr9/eoOWF1Dbogb6ALuraK5RBTK6Ez9s8WnCDarj+CTFzm9TJIVeU
         BsU6pP2AQg37DCTdTXniCbXaDaUw48guZUwwPkq9XDmbBzYPnGvsyLajHs+vmnP0N35n
         xRcjCRnioLf1K0klm/mX77JLubwwln6V74XxJKFr30HEulbTZafRf/jOE3mjl1/5Debh
         xmd9uaw4uQ2UM+xab9gcLfBrFmf4TDAtabCTixDCizRxEXHxzpevc2hW/M3kAePRku+R
         7QJ8fTKFgSTs9H5JPrrMAYaoAMZr7s7rh1q1Z85mK8zoF16K6eLnn3mdqOXACivnlPP4
         +MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753442083; x=1754046883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaiH/38WONPy8fzRyhRHdFQdB6YbrzolydS9CtzX8Do=;
        b=jYIut+RtFXuTkE3xHMuh0c48vRQzHWd8JkxCceK7/nHPEdVE3piYvil7f2sTatHisM
         in7wCa3S6xqWXigT5bELREmCJwbEM6oxqGEx3utIEQvG0iRy5f1nRQ7X/v5GnKBrnc7y
         25heDHW8uAS1UOztcEaEWvXro2oXx6D3mddlk6+Fh6yu4EWEEJbBOAQluX/p76OXR73J
         qv3z5LqNbaWDLxHo8qswSb7K4GK61uo3n+8PHvf9K73fw21z4IDBoTsrxtoAgOJ0A9Ty
         JNH5C/fJGsnkRwxcldbFjz5K0k53e/LInnt9mbF5VD2ewinCQ+rbEgZkTn0P7QJSnlex
         cVXA==
X-Forwarded-Encrypted: i=1; AJvYcCV0ilLWR2GX3Su0BoiHW5xa8gAm6R4nLppkaLbMqoF6+ywAiKBsyPkD3Z6nq2vJokgKwhxufwhHy0lT4wJl@vger.kernel.org, AJvYcCWR1i3rhicngvoi8EwOPmCIjLb2QvMfEEZrFchT82sC6UTFwOR4r+anRBSXZRavk2Plu1Q3FPdw2Gf0BnwB@vger.kernel.org, AJvYcCWyjDVXWjUl/ZmniD3s0uN28riUf/Hs8VGwoVdb+frfFUT92DkSETpZBlL9BUFS886JKpXnfyqufb31@vger.kernel.org, AJvYcCX30s6iEEZyOO99gQZ1Pd7Ze4QaoE+kPOx52fF5tLbnr2x08dIOyOfjomIWWohh9a/6R1Ooeq1dGTGt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wKS3Ow35a07GMxI+0BBGNqpQyFTryG27sAwh0opR76FwTtpG
	ZcyjA5FhGcNeaPCTCfnBhL4OsNopb78fx5JjR1xi7rgFD8pYZWJZ868x2m8+9tDY+QA5Kpe1NI6
	3DSlFi2gfPSp+AGUYBMA3lFRwBp/Pov0=
X-Gm-Gg: ASbGncuD4fbjM6Q97af0RC+fv+QmOUJMW8SyhOGKciU4damHubCSsUrvoftbF/Zv7Nd
	HWT3a/WXZwPfNiDUCjd3wFhCBduQFCvlysBZ6I8kF7dur7LzbvpQNSz6tLZ/GMDrpVTp4gI9e+M
	RBcwuB6zlLxnNODagiHFKkplLdJnb+XiBoG5mivn95+mu2X+ot/2bCtSPDdi0BDOeIn119alSPV
	73E
X-Google-Smtp-Source: AGHT+IFVx1ZwuhzWu29nMel9dpd38C5+YSpTw1UCZrJubHtDeVnxnQB0fu/r5r4nXrA8TmFpU3Uh7Qk/EellC8klWWQ=
X-Received: by 2002:a17:902:e948:b0:23f:b09f:52c7 with SMTP id
 d9443c01a7336-23fb3043a03mr26463905ad.23.1753442082654; Fri, 25 Jul 2025
 04:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-10-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-10-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 19:14:06 +0800
X-Gm-Features: Ac12FXwWTPyxekGMep4sx35p32LI3MXjz9EYbsvnC9mgbg1lm2slnKe57OCBYTs
Message-ID: <CAMvTesCWTcXLxjOVyNF4pTqaQkXQsgKBXn1TQdK+n-9TfWfndA@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 09/16] Drivers: hv: Check message and event
 pages for non-NULL before iounmap()
To: Roman Kisel <romank@linux.microsoft.com>
Cc: alok.a.tiwari@oracle.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kys@microsoft.com, mhklinux@outlook.com, mingo@redhat.com, 
	rdunlap@infradead.org, tglx@linutronix.de, Tianyu.Lan@microsoft.com, 
	wei.liu@kernel.org, linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com, 
	benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:16=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> It might happen that some hyp SynIC pages aren't allocated.
>
> Check for that and only then call iounmap().
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 820711e954d1..a8669843c56e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -367,8 +367,10 @@ void hv_synic_disable_regs(unsigned int cpu)
>          */
>         simp.simp_enabled =3D 0;
>         if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -               iounmap(hv_cpu->hyp_synic_message_page);
> -               hv_cpu->hyp_synic_message_page =3D NULL;
> +               if (hv_cpu->hyp_synic_message_page) {
> +                       iounmap(hv_cpu->hyp_synic_message_page);
> +                       hv_cpu->hyp_synic_message_page =3D NULL;
> +               }
>         } else {
>                 simp.base_simp_gpa =3D 0;
>         }
> @@ -379,8 +381,10 @@ void hv_synic_disable_regs(unsigned int cpu)
>         siefp.siefp_enabled =3D 0;
>
>         if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -               iounmap(hv_cpu->hyp_synic_event_page);
> -               hv_cpu->hyp_synic_event_page =3D NULL;
> +               if (hv_cpu->hyp_synic_event_page) {
> +                       iounmap(hv_cpu->hyp_synic_event_page);
> +                       hv_cpu->hyp_synic_event_page =3D NULL;
> +               }
>         } else {
>                 siefp.base_siefp_gpa =3D 0;
>         }
> --
> 2.43.0
>
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
--=20
Thanks
Tianyu Lan

