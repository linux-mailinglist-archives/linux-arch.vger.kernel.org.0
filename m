Return-Path: <linux-arch+bounces-12952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4599B11D2F
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 13:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A85BAE3793
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8A2E6112;
	Fri, 25 Jul 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwNxI0XQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B812D9EE3;
	Fri, 25 Jul 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441756; cv=none; b=B8BbC8J6ja9IQTDaojOtqPcozWN3leJKoWRz+nxIGIiJl7AT3dl5InARX2QfCCjQRbk9YU5bU6/atPWfM/SS5DscCwsD3zsnnMgyEAEKEj9tOya3mkfhLAXtfefjFjfU1ws0Nvx4gZxcl55M5vjL7UO8X4ZFazj+5WoduTgX5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441756; c=relaxed/simple;
	bh=r6TFW6LEnDFDgljm7T9nclsKj7smdp/z2thlL3Bp7MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km27GBAp9M12+gVvCVV978gQRmORYYjE40Y4FQcI6PWlNQ2EB2sT1sDTu+QE0KsrtOGaCU1p/yvWX24GHK5/rrI4pyJDbfX7zQtcpWRHfm3tgg1BQhb4QMrggGzauknVlkWcXj1rl7Zg1hCiPdx5/B4uiG+XZ6qzbQPW1opNO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwNxI0XQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313910f392dso1500508a91.2;
        Fri, 25 Jul 2025 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753441754; x=1754046554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4dcsgHJsiFuB5DH2cQD4a717boBYqK/NeHn/u7KI9k=;
        b=RwNxI0XQAEQIiS6E1e253nyKMK2uTvj04eFBT3NZkGmF9e0huW1toU+1D3BDPEM4eh
         Str5whAgWMIo4Y9X6C8Q96JwLoj5Liw01k/G03jgce8r6L/zTMdkwB9e+WSFpapEXpol
         gO4PKvt3wlFZMORGYj9hZbbiw8FG8mriCizhpDnWB7C8PCKLYBitHsODTeWRbTWWJPVs
         2H/kw5SI+ChRB6wMx43/ktNmX59i3X25c1U5eaWawE/2gkIiywWuZZ3gJX58To/k09Ic
         aRwMthLXrg+GIkFuEHwR0mZIsHnaMzGPUm+8Sl57vr/lveQvRZlm4X5Q7PGdLcSMJXUE
         /pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441754; x=1754046554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4dcsgHJsiFuB5DH2cQD4a717boBYqK/NeHn/u7KI9k=;
        b=CWpDKsANCEtzPuoBjLUgLlfkKPvlzIQC3TZzxrzBY4RcxNpBeTvb2gOqeVadAoQH/I
         +keGYh0eGo7vDBuB6h7qTfcxfWYRLUDU8XH0aFYvE6bD6PFbADoqfKGOJbP9BfOKcJQr
         51q6VB+g8jWb/9F8UY6ZKXMnC8fncw4+VtvqKnZLEcsChuah5Qa3mTvHcOUbOvuvCbOA
         VxRN8YgGJ0ORKSFLp8XZIRoDqaQK7PV5uZEf1Hp0T8cDsVOGJc6KC+hfP/8Xi19t7gyN
         LCbX8jLFhBBYqLu6AJqWljRsfvUTw7ENIypsZXtLbU7F6RN04Cf2hhsrIfq2+0UANbVz
         ozPw==
X-Forwarded-Encrypted: i=1; AJvYcCVTQFHZRs51VWmmh9bzdo2SKcGaKlyjwXS0khxfprM3u8pRBmSXHp+660zJYi3PeIGxpd5P7uXcyH2ia27Q@vger.kernel.org, AJvYcCWGQ2QK/dmY2L2i2juUJp3HyD9ncAcwbdT4465Ki1S4t/nkYqbFLkdTOLqCPdl+F1gN8vH52d/0SymZ@vger.kernel.org, AJvYcCWmp2yT2H/AifgMtNABFmL5W3/5IsoRhdvxMLQhS6cypXcey5TfIWzxYKSDUH6DggOeZzrRZSeIngHE@vger.kernel.org, AJvYcCXEXAg8TrfgXZknSw1vfzqpr+JtV25WLbbKSPHq60xVU0+76rBdITj/v/1BC6I+2hAxLPUslCwKIesmFxmx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eSLUM5WppKHPa96aHSrBLO5d4LxjVALvKjWxOQxxVzbueTNp
	N5NfASY045Pl2zK5uK104DnBO6HyPo//aTt7QWwcMdmPkqxVV1SfgeT73XoWJcvN3rJM6ZAzDIR
	XUR+PatF10wkysZhd4SCcncCUc5p/iEA=
X-Gm-Gg: ASbGncvS8sI0oWVcHR2vPuXhOG9rn+YUOE2BIdZV7AD7GUQTb8vXwSHAIFh6Ifntolm
	EjNXEWPDpJYeHruwo6u7khCW8tJG8ZwVcbCebvuo54/P155a3y7BEMSo2lFr/FlXPKq/IVUEG32
	z+muO+rqRjJeGlTdosf9xU4UXUtU9VtPfGQJqtI2GyslfT+wmvjC9h+0bTE9ksO4DA/GMio2RKR
	1Xj
X-Google-Smtp-Source: AGHT+IHzc69ul6W9dr1PZNQjrkdeeaQAbz/elxAykodnDXCU37bqxvv59Sf0g3PkwZUP1bQTMcpl5i4V0RAyNvW6vGY=
X-Received: by 2002:a17:90a:d40e:b0:313:1e9d:404b with SMTP id
 98e67ed59e1d1-31e7783b3c0mr2460183a91.2.1753441754040; Fri, 25 Jul 2025
 04:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-9-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-9-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 19:08:37 +0800
X-Gm-Features: Ac12FXzPuW-X6w99YdkxRL9JtBmW1hyu8BbtCuoFQLmf7Mp6jVRHMfrBCkYMIAg
Message-ID: <CAMvTesDEqDKXdFZ6+k6nrvEx-9+HQuC_dOdmoN5SqXmoCEKNXg@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 08/16] Drivers: hv: remove stale comment
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
> The comment about the x2v shim is ancient and long since incorrect.
>
> Remove the incorrect comment.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 816f8a14ff63..820711e954d1 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -266,11 +266,7 @@ void hv_synic_free(void)
>  }
>
>  /*
> - * hv_synic_init - Initialize the Synthetic Interrupt Controller.
> - *
> - * If it is already initialized by another entity (ie x2v shim), we need=
 to
> - * retrieve the initialized message and event pages.  Otherwise, we crea=
te and
> - * initialize the message and event pages.
> + * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
>   */
>  void hv_synic_enable_regs(unsigned int cpu)
>  {
> --
> 2.43.0
>
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
--=20
Thanks
Tianyu Lan

