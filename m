Return-Path: <linux-arch+bounces-2171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229628503F9
	for <lists+linux-arch@lfdr.de>; Sat, 10 Feb 2024 11:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554321C2162E
	for <lists+linux-arch@lfdr.de>; Sat, 10 Feb 2024 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5B3611F;
	Sat, 10 Feb 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fiAme/xL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D402E3FE;
	Sat, 10 Feb 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707561674; cv=none; b=qbs4PwRY6Y6/dpwBEWhDNDQ+YSPzfKDIRFcxi/Ejmwcdx5aIl6frNU2pMcwCPvoDJuxa422hg+7ESWAu/MgV29HHTT5Orh6kWdtSUjqRCm5zdHEBIMhAMK1srTmQ0m6jqd7t9o2g9otCtvUBsxmazc3Mp9Mr116q7a2OhTbXLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707561674; c=relaxed/simple;
	bh=x+rMoLaemDU7O0UiEISg9iBNvLvyhD2E78cUrJEqRBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1PeMY+WJrx+xLYGBTCZi0TxSwrfUnn0F26ugm/IKVgdn884fXpuULDdCoPcMb8BVc59JjRXV/Kpv7BBpXBpLHU3A94FCgKL7QSFrp2Mt2N99IIYkoyM5ucvwRACfNdYvs8m3dOwAv7wNMIbkPO/6xilVIMYl8nrV9J12wBurIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fiAme/xL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C03140E023B;
	Sat, 10 Feb 2024 10:41:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m99D3Vit8Jsc; Sat, 10 Feb 2024 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707561663; bh=dSjCyKghVnE+pRQUrxWXdE0XNE6p+IPHoxYYpdgP9us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiAme/xLbxI9xs3wkAhG1kZG5wyVoM4V1XKCVCC0swGLdmtiwa7MaO03/y4OHEjNs
	 VaB3vxeu4id6Kq/X3yNPcD5f5H/NYek5IrpW5gjDvSo7KZJ8r7i46phk+mNGdmIHl3
	 3fJ/+riwV4dPYtLefa9scDtwq+7ImGpJuJBcQ2POuVrgufM4PatyrqhUBuR6r76AvS
	 CBfq9BO8MC9J0ItBR9jHj0WjYaV+Fiscoe75TZI1h+bBM5mpo2buAfzDkV3Q5saYhb
	 RGdVnfvTTJzDN6G2d9QAfhJmOO6G1Nmu4Yk24+t8OqHVoVoq1DsEU2kRzOq0BeF1Yq
	 godtyWo/kG9rZ7GBvqawDR8utdWnKcBb85Adej0ZoXeIpTm6PJ9gyZO/3zFFZyHlCe
	 PRBTcGwwo+lewUlDtol/IGPfY0Hb9lw5efXRXrIHcHLeou+Uaka93qqvFjUtVDYKJe
	 lyiE/dWBk5LHnmJawWmL6J61WY+c51s4HkceOHpviRgQG5g1Bo/IU0IFGWoaM22+xj
	 Z1GhrW365Yh7OxZaGQ/llEAaPNQULy7aiaOmn+wa7OOH32rElcV5XnxMjA+qh7tCiR
	 ksU2V4la9EECtnshreDatfablejJLgN0BBsdz1khmWYmC8j4NpQijZw9yT2GljUtXb
	 /OfWu6tyQrxRaT1hEIqhwm1Q=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A027140E016D;
	Sat, 10 Feb 2024 10:40:45 +0000 (UTC)
Date: Sat, 10 Feb 2024 11:40:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 06/19] x86/startup_64: Drop global variables keeping
 track of LA57 state
Message-ID: <20240210104039.GAZcdSp7dRbgqBy3fg@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-27-ardb+git@google.com>
 <20240207132922.GSZcOFspSGaVluJo92@fat_crate.local>
 <CAMj1kXF+mHCYs08q58QFGuzZ4nzGd2sDr1gp2ydkOHHQ2LK5tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF+mHCYs08q58QFGuzZ4nzGd2sDr1gp2ydkOHHQ2LK5tQ@mail.gmail.com>

On Fri, Feb 09, 2024 at 01:55:02PM +0000, Ard Biesheuvel wrote:
> I was trying to get rid of global variable assignments and accesses
> from the 1:1 mapping, but since we cannot get rid of those entirely,
> we might just keep __pgtable_l5_enabled but use RIP_REL_REF() in the
> accessors, and move the assignment to the asm startup code.

Yeah.

>    asm(ALTERNATIVE_TERNARY(
>        "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
>        %P[feat], "stc", "clc")
>        : [reg] "=r" (r), CC_OUT(c) (ret)
>        : [feat] "i" (X86_FEATURE_LA57),
>          [la57] "i" (X86_CR4_LA57_BIT)
>        : "cc");

Creative :)

> but we'd still have two versions in that case.

Yap. RIP_REL_REF() ain't too bad ...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

