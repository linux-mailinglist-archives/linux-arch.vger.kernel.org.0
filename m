Return-Path: <linux-arch+bounces-1369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BE82D7B6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 11:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9DC1F21F4A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2C1B805;
	Mon, 15 Jan 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sz3CtW8T"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5462BB00;
	Mon, 15 Jan 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BZWJhywUMRRIXvtL5doMOpnSiLPQBWG9w9WPF2MUO4c=; b=Sz3CtW8TvMYVj95XL1EZCET2A+
	QamuonxIFNT3zYkRLRtfqxw7SE6Ou+c1sDlHOm3gafCTRQqOLJZCqlQDm5FD6J4qrogV6aC9NBqKU
	UvioOgQ7gVTi/liinVC4kVe/e4buW1OQKg1r4GMXP3iDla1Qt5/Ci+N1I7TqyALOM7ZH/njEyXM+O
	kqJMAfgr9yHj6be0TqV5AqRnblBaGfn2ZJHMunrt6qJ0b7/ZJ87rjdKUjRsvXgIYphw4O44+TlX5o
	PSgdX1SN3rxuaPmO/lCvJycV2gVlF4hse5S9MWc2dj0rsOcECr0O+epZD/m8Mped50SRNjDOgOXs2
	5FXDnxHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39864)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPKUr-0002Ja-0t;
	Mon, 15 Jan 2024 10:47:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPKUm-0002tU-5o; Mon, 15 Jan 2024 10:47:08 +0000
Date: Mon, 15 Jan 2024 10:47:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZaUNLMvIYChv6qai@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
 <20240111175908.00002f46@Huawei.com>
 <ZaA3l4yjgCXxSiVg@shell.armlinux.org.uk>
 <20240112092520.00001278@Huawei.com>
 <CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 12, 2024 at 04:01:40PM +0100, Rafael J. Wysocki wrote:
> In any case, it is always better to work on top of the current
> mainline code IMO.

That's fine if one is starting to do some work now, but that is not the
case with this. The first posting was almost a year ago:

	https://lwn.net/Articles/922127/

which likely means that it's been around for at 18 months or more, and
we can also see that this patch was in that original patch set. What
the history of this patch is before the first posting... only James
would be able to answer that and I feel that we're highly unlikely to
get any kind of response.

Anyway, consider this patch dropped from the series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

