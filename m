Return-Path: <linux-arch+bounces-13485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED70B526B6
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 04:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BE47A83A0
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 02:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D822332E;
	Thu, 11 Sep 2025 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdILawbz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D733D8
	for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559353; cv=none; b=t+RbOVNksa1ujea9wzhydMYTiltjpOoQr9rq9S9sKB9EUbVhvBRMq4h6rUBuYlOC6RDtr1tApxWdnt9FDCEa9hK+kwT5SobK7IVWTeVLzbyOvnVizlGaQkIAHrQDEPIKZ4Z52BwCHnfP5ex9MGZzF3yzMIllA9YPTLudoQmz0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559353; c=relaxed/simple;
	bh=DDfAOSyzJhqT3Tf+NF0sXaUg/RYY6cskTzGSaREI0iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDc46+L54TyFWVF5Z/fW4dqCLVOo2CBVe1gNOZ5vXyKyKW7pqWXSE+HZALeip3vk+CNcR91YUWryNbulJ61mh9W9qo0IgUyieP67Hod/wpgpZnOSI1ecl/i/j4py+q8L+bzHHngRCyzffIml5Qlsb195kn9/iW1EQ9p3Am7XilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdILawbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A25C4CEF5
	for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 02:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757559353;
	bh=DDfAOSyzJhqT3Tf+NF0sXaUg/RYY6cskTzGSaREI0iU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DdILawbzsINzu/19D2zlcJqy/sXjiyx6IWbOMspFGMtjcEDSzXi5CiEhr5t31bhLD
	 Jq6wnN0XY9lKElb6npQirGVK715EQGFoaURMx5jFOryiy81uO3BKx74qRz3ubXTCjQ
	 YAhcuiy3ebyOAQ4D+ygVdutwI2ypd6c21VjQyAdELuM9z1T+pcGv6JyXITxgPzyG1E
	 1lhlyCV3HWmQ8br7n+g6wST2fZ388020pcEgFyJHTXXPPgFiAjNUE89xp771aHcf4W
	 fRNVPa5Dcnfy1yURNsbkyqnKmejt68oDAUnleeK2sWtbab/9VwTZztlyX1Vsk7g12k
	 y7O33T+YDYqyg==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e75fb6b2e2so212422f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 10 Sep 2025 19:55:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwziWiTu9lDTJpG5At4LstHEQIwaXtjXamz3CK/Ctu1Uj/0Bp+6
	NU63fPlvcaRBYP/ena0N5XVGebS/BgcBL1BGO7dKlNGnqYp8tEwELDaLTKdZoym5diHfZW+YfmE
	Jgj+rqsPXDo8tqHd1gReT9FApY8neKPk=
X-Google-Smtp-Source: AGHT+IHDMQn7UTuiBgeeLnVGTJDMrJJxqbHYUMdKohCDyJEY8OP1YYmDjGqgKS0f+WWnJ0VgkC2JIZNhLJ8jQEQPM+M=
X-Received: by 2002:a05:6000:3101:b0:3de:8806:ed08 with SMTP id
 ffacd0b85a97d-3e64c87e270mr14845880f8f.61.1757559351914; Wed, 10 Sep 2025
 19:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911015124.GV31600@ZenIV> <20250911015223.GA2604499@ZenIV>
In-Reply-To: <20250911015223.GA2604499@ZenIV>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 11 Sep 2025 10:55:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSrP7OMstQzp3Nj1a-SgoDgSDu-Vp1pQXKAcVzSiLekDQ@mail.gmail.com>
X-Gm-Features: AS18NWA2mIOP6sbgtwT0itGqg0NHul4T68a_Bg-CwEPLoeBjX1DdHxPf1LtUjSw
Message-ID: <CAJF2gTSrP7OMstQzp3Nj1a-SgoDgSDu-Vp1pQXKAcVzSiLekDQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] csky: remove BS check for FAULT_FLAG_ALLOW_RETRY
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Max Filippov <jcmvbkbc@gmail.com>, Jonas Bonn <jonas@southpole.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:52=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> flags are initialized as FAULT_FLAG_DEFAULT, and the only thing done
> to that afterwards is |=3D; since FAULT_FLAG_DEFAULT already includes
> FAULT_FLAG_ALLOW_RETRY, it's guaranteed to remain there all along.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/csky/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index a885518ce1dd..a6ca7dff4215 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -277,7 +277,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>         if (fault & VM_FAULT_COMPLETED)
>                 return;
>
> -       if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLO=
W_RETRY))) {
> +       if (unlikely(fault & VM_FAULT_RETRY)) {
Yes, FAULT_FLAG_ALLOW_RETRY is unnecessary.

LGTM!

Reviewed-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>

>                 flags |=3D FAULT_FLAG_TRIED;
>
>                 /*
> --
> 2.47.2
>


--=20
Best Regards
 Guo Ren

