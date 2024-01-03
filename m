Return-Path: <linux-arch+bounces-1248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD82823768
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 23:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BD6286DBE
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 22:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8CF1DA32;
	Wed,  3 Jan 2024 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpXlMTzk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0781DA2E;
	Wed,  3 Jan 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so114766e87.0;
        Wed, 03 Jan 2024 14:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704319339; x=1704924139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpGxvJJtVuRyxsqphq2dwO+9B0ywma0/dFHTznJHn7c=;
        b=VpXlMTzkJnynyM3DtgMrQTV4xXVi+AfbsiQ6eDNSi1cVBeM9M3ha9k+KusQb4VLumK
         LWIcjkD84Ahl+au2TZwdKoo7v4/e2DEfXXiJfy1bxlYqzVi/OivxKAI43Pdzif2DruMV
         V4AuP+02n0OH7s7jA1iOLpjQUuv77twHu31X8+fw5iRX8GtXTuvYYffAaDDFcl5UoYSI
         WyrjtaXrhZIQxuDyCskvBfaIiDwg1WmL3C3gQrrebM/WzyefErMyB8C4VQozLw81vL8r
         ul2hwCAdqNfbNgI7k+8/xTIBNhnYHRrMBK12YhkMfbw7xZ4f4v9b8+w0vx+0WMVPtuRz
         iAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319339; x=1704924139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpGxvJJtVuRyxsqphq2dwO+9B0ywma0/dFHTznJHn7c=;
        b=CaTrh+EnB4QByc0BszPBl1mQTYkg4e6Ccd7uG/06m64eUNXfpplFj55GCbKh+b4ip1
         4Idl1cEFnhseIcD2RcDv78TabwKX2DEx0EAfldbXgpKZXPo5i0Xj3BpUa+93BRZWbXOH
         JPmM/A5Vq6EvnUBqC062U1433Y+Y6lKrBM/+wV6ij4GlMkCDbS8Xmeh4dkCOvPBLQECp
         xp07Cv5H5N+G1osJ9+r+PCQU4X2Ld22EtIKtPPosm/GTS6FH2/5CF49MU5a0syT4i3Vt
         IE0B9t4Sp26Fm9Zx1yuf3C9WCzhAumIxfiF+MLxlT9WLl04a5vQduDKYJSyOmSCO5nFw
         q9MQ==
X-Gm-Message-State: AOJu0YwrPLfIX5B5za6livKU0it+LVKXBG8NUY14WrJwkS9k2iU1WoyW
	ClE2o2OkQC3W68mg7c6+1vsuC2Uw7rsxT1sIiK7dnEt3
X-Google-Smtp-Source: AGHT+IHeiXD806mZ+5OSIFgeuyavx5NaQpFe85WtKWyZB+g2tl0EkphiF8IBUK00SJhJdp6AVstYz4xla2dq/McITrE=
X-Received: by 2002:a05:6512:1581:b0:50e:902d:b48 with SMTP id
 bp1-20020a056512158100b0050e902d0b48mr4158983lfb.64.1704319338652; Wed, 03
 Jan 2024 14:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205022100.GB1674809@ZenIV> <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
 <20231205022418.1703007-27-viro@zeniv.linux.org.uk>
In-Reply-To: <20231205022418.1703007-27-viro@zeniv.linux.org.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 3 Jan 2024 23:02:05 +0100
Message-ID: <CAFLxGvxsDQK3h-b6zDOR5nv+8kBaaTCqJ7hWDx=QMtysr=ZRJw@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] uml/x86: use normal x86 checksum.h
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, gus Gusenleitner Klaus <gus@keba.com>, 
	Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:24=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> The only difference left is that UML really does *NOT* want the
> csum-and-uaccess combinations; leave those in
> arch/x86/include/asm/checksum_{32,64}, move the rest into
> arch/x86/include/asm/checksum.h (under ifdefs) and that's
> pretty much it.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard

