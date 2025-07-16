Return-Path: <linux-arch+bounces-12824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D20B07C69
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7047507AB4
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6228853E;
	Wed, 16 Jul 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nRf9s6BL"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54296262FDD;
	Wed, 16 Jul 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688738; cv=none; b=gssoGhK8v3Qi82rqgOLaIwoOAnT0GPLtt9JIGE8k7hodRJ00Bio0vMoj+evMQY92jb54sHlEkMZpxeReW5pTbO3/DPApkCZtV/+DYD8Ytb/whEWmH0Kjw/nusPvD6jdC5Os2ybsnlnkW3rJOTVNNBVNbESwgcNDFoHz+Sj/hnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688738; c=relaxed/simple;
	bh=r9Q0Jz62s1sQSj+wQwDHRUQ0P8PP5NzmnViN0MYn520=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfmgE6TPUKWcDT/Qp7lkR/nJSRfabq9hHRvUntKWOJqb0ZGfUB2sbKNC7zm6SBI5QL+0uwBdPBX7lliWsIopew/6QKvrOCADnValC8Ds+JqtKhokClQ4XN6mSRH4qv8jXu6w3/KrwQLKuKiM6Ocv0z7dUJMnawdWW4bNxKYy2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nRf9s6BL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j/rIFur3u1rTJo3mQ89YHapN8kPR0kc82DFGfxLgJOY=; b=nRf9s6BLgyLZd19Zq0n8/XzeaT
	LdIYLNiW4z4oi4MA3w2BCBek25oSOrhZ8XcpzyleTM/5SuM2dnCE8X2IN1fY4XF02MN0u0o/w7o+/
	BXK5tT7Nngm6VEQKAzarLu64KjC1zHm0osARGnNBRaSOJzAQTBVqTSgVCUR5io769aa33pkqg0Klq
	UjjCl8EoyWky+K3kmjxhwmz+159ClWBAoAk+GeDtMb/6pA/oHGkodOfSrEn4YCwUGtQ02pz9D/Oym
	S4R+vEsvs+G9YBBJckDetnAWXJTk+T1i0vJw0SDz0Cd6j6QJIV/W8Xmfday5WtRq/NdxL7Nikft3h
	+JKcvcMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49400)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uc6Nh-0008HA-0J;
	Wed, 16 Jul 2025 18:57:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uc6NT-0001JC-1H;
	Wed, 16 Jul 2025 18:57:11 +0100
Date: Wed, 16 Jul 2025 18:57:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 1/1] uapi/termios: remove struct ktermios from uapi
 headers
Message-ID: <aHfn9z9_oIVgNGgx@shell.armlinux.org.uk>
References: <20250716164735.170713-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716164735.170713-1-hpa@zytor.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 16, 2025 at 09:47:32AM -0700, H. Peter Anvin wrote:
> diff --git a/arch/arm/include/asm/ktermios.h b/arch/arm/include/asm/ktermios.h
> new file mode 100644
> index 000000000000..4320921a82a9
> --- /dev/null
> +++ b/arch/arm/include/asm/ktermios.h
> @@ -0,0 +1 @@
> +#include <asm-generic/ktermios.h>

Isn't this what arch/arm/include/asm/Kbuild's generic-y is for?

Ditto for other arches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

