Return-Path: <linux-arch+bounces-3326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD789144F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3EE287A08
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440742044;
	Fri, 29 Mar 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q9KYzPmV"
X-Original-To: linux-arch@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234640852;
	Fri, 29 Mar 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697187; cv=none; b=hw6Eis9ddJb9IwD2cv+WrzkxEgnn3ggAGYt54NetTIUX2no+Qrv0lhTaC+E5WVBzbiJIvjMpiaLQysG1JxwHd770r0LyUJHdm1b/q8aDwKBYYlSxZoRZslPS3kXXSgQ5MgGh57+kr4yI6ZvJX+kDedmgKjv3cgW5fKfFcadPR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697187; c=relaxed/simple;
	bh=bInZpQe27T+FP7otvnqd8TxPV4Zh13QdnbFoeMPgJnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eENRMVkbYq0Ozk126qilqOn8vnqfbV0JoR/eKYpsdKXVETtdecyS5UKOqPO2VsixeRY8cHbpY3eohIsJcaUAL0650rRGo3ZD6Ky4pa1pBOc1DO8djG6pkN3YaZLCtmRqcOv45EDzuuHsmkBVbYlLSmYaXF/XLFhSY51t1mbEMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q9KYzPmV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711697184; x=1743233184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bInZpQe27T+FP7otvnqd8TxPV4Zh13QdnbFoeMPgJnc=;
  b=q9KYzPmVJjrJ6tgXYfLM0nykx+0MF85Rv9lRi5SK4IlswgbmhkfvpkU1
   McZnx1IyjywhW5dOhKUiDz/GYTG5lhKOpC8z/eLroZ2E3dNbOdE4dc0Sx
   CoQYB1SdH2Uud/yTiymvOP7RFYNJkYnOWMq9kpmSTTTz1obfHZI/eeWhL
   kndenZr2p7+q6SLDRTRiSav3rYwG2B8fTT8xWvhCQfj9Yr5NrRZORoGDm
   axA2QjRMetVFd7MbTexiRrdvy3hwf5j8IFtHXTN5d8Fnz1CaJaKV+OGOD
   kLrwA7mokw6PLG5tkRX9l5VAMPE8t22/nfeLGPiJZsp6kDMAQZ5Lv2HUh
   Q==;
X-CSE-ConnectionGUID: 15IXURycT2uyFkZ6j12usw==
X-CSE-MsgGUID: 3NX0TeF6T2SxAshBbDmoVA==
X-IronPort-AV: E=Sophos;i="6.07,164,1708412400"; 
   d="asc'?scan'208";a="18569006"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2024 00:26:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 00:25:57 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 00:25:45 -0700
Date: Fri, 29 Mar 2024 07:24:57 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Deepak Gupta <debug@rivosinc.com>
CC: <paul.walmsley@sifive.com>, <rick.p.edgecombe@intel.com>,
	<broonie@kernel.org>, <Szabolcs.Nagy@arm.com>, <kito.cheng@sifive.com>,
	<keescook@chromium.org>, <ajones@ventanamicro.com>, <cleger@rivosinc.com>,
	<atishp@atishpatra.org>, <alex@ghiti.fr>, <bjorn@rivosinc.com>,
	<alexghiti@rivosinc.com>, <samuel.holland@sifive.com>, <palmer@sifive.com>,
	<conor@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<corbet@lwn.net>, <tech-j-ext@lists.risc-v.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <oleg@redhat.com>,
	<akpm@linux-foundation.org>, <arnd@arndb.de>, <ebiederm@xmission.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <lstoakes@gmail.com>,
	<shuah@kernel.org>, <brauner@kernel.org>, <andy.chiu@sifive.com>,
	<jerry.shih@sifive.com>, <hankuan.chen@sifive.com>,
	<greentime.hu@sifive.com>, <evan@rivosinc.com>, <xiao.w.wang@intel.com>,
	<charlie@rivosinc.com>, <apatel@ventanamicro.com>,
	<mchitale@ventanamicro.com>, <dbarboza@ventanamicro.com>,
	<sameo@rivosinc.com>, <shikemeng@huaweicloud.com>, <willy@infradead.org>,
	<vincent.chen@sifive.com>, <guoren@kernel.org>, <samitolvanen@google.com>,
	<songshuaishuai@tinylab.org>, <gerg@kernel.org>, <heiko@sntech.de>,
	<bhe@redhat.com>, <jeeheng.sia@starfivetech.com>, <cyy@cyyself.name>,
	<maskray@google.com>, <ancientmodern4@gmail.com>, <mathis.salmen@matsal.de>,
	<cuiyunhui@bytedance.com>, <bgray@linux.ibm.com>, <mpe@ellerman.id.au>,
	<baruch@tkos.co.il>, <alx@kernel.org>, <david@redhat.com>,
	<catalin.marinas@arm.com>, <revest@chromium.org>, <josh@joshtriplett.org>,
	<shr@devkernel.io>, <deller@gmx.de>, <omosnace@redhat.com>,
	<ojeda@kernel.org>, <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 04/27] riscv: zicfiss/zicfilp enumeration
Message-ID: <20240329-condition-morse-c3d02720853a@wendy>
References: <20240329044459.3990638-1-debug@rivosinc.com>
 <20240329044459.3990638-5-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kiXl0dlDZ9ZIiu8P"
Content-Disposition: inline
In-Reply-To: <20240329044459.3990638-5-debug@rivosinc.com>

--kiXl0dlDZ9ZIiu8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 09:44:36PM -0700, Deepak Gupta wrote:
> Adds description in dt-bindings (extensions.yaml)
>=20
> This patch adds support for detecting zicfiss and zicfilp. zicfiss and zi=
cfilp
> stands for unprivleged integer spec extension for shadow stack and branch
> tracking on indirect branches, respectively.
>=20
> This patch looks for zicfiss and zicfilp in device tree and accordinlgy l=
ights
> up bit in cpu feature bitmap. Furthermore this patch adds detection utili=
ty
> functions to return whether shadow stack or landing pads are supported by
> cpu.
>=20
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---

>  .../devicetree/bindings/riscv/extensions.yaml       | 10 ++++++++++

Checkpatch should have told you that bindings changes need to be in
separate patches.

Thanks,
Conor.

>  arch/riscv/include/asm/cpufeature.h                 | 13 +++++++++++++
>  arch/riscv/include/asm/hwcap.h                      |  2 ++
>  arch/riscv/include/asm/processor.h                  |  1 +
>  arch/riscv/kernel/cpufeature.c                      |  2 ++

--kiXl0dlDZ9ZIiu8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgZsvgAKCRB4tDGHoIJi
0iYTAQD/x2jCSMw3PvwFsNJ6v7adg+YdWitg5NvBburVYvIikAEA0Qu7dWdDtcJk
H0K8lWXiWqqumgSgXhcWgk/Gp2U1igQ=
=0twh
-----END PGP SIGNATURE-----

--kiXl0dlDZ9ZIiu8P--

