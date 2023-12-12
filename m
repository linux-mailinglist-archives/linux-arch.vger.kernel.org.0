Return-Path: <linux-arch+bounces-933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E780F7B1
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 21:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CA41C20C7D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F963BFE;
	Tue, 12 Dec 2023 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Le1a7b+M"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E04DB;
	Tue, 12 Dec 2023 12:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PDwWMvE707rKJbV02zug7t37qFDv7YOoytMyP2X6xyQ=; b=Le1a7b+MYxlb3kfygQ0jhZGDz+
	1KEl3WefH1wExk5k9L8RKfyjQb31NtNsFDmeS4rbyNsnV/AXUNGZ4lb5p5n6bzlws55DQTx6h0Pci
	2u3wY6NiE6B+lMqsPbDzadz2m2GUvO+8cAcQqTDUn2jhye7PisBrMewyqd/QZUPpAurEe+jBmHuOo
	QZY3oxISKjP6uooc+4ddKW0Y68+IKpagaLdIr/CvX94n5Xo5rkXFcE7Uvf+3APlWLA0ytjjrnZlrN
	8dsbOoFtwrn6T2CxI8FRZWBoRtSUTRQ8ww5gyZJb/FHHmDSGFj8cA+TDfANxb1MalWyb1DtUqoygz
	L/AUbcjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58234)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rD9Ba-0007OH-0y;
	Tue, 12 Dec 2023 20:16:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rD9Bb-0000jo-UJ; Tue, 12 Dec 2023 20:16:59 +0000
Date: Tue, 12 Dec 2023 20:16:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
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
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Message-ID: <ZXi/u7dZ20oLPF9n@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <CAJZ5v0j-73_+9U3ngDAf9w1ADDhBTKctJdWboqUk-okH2TQGyg@mail.gmail.com>
 <ZW4ZBkj2oCmxv55T@shell.armlinux.org.uk>
 <ZXi7do4mVfdsz/k0@shell.armlinux.org.uk>
 <CAJZ5v0jOU4Re2g5QtxpG0RjP3MYBxqz5Z+TtfXq2dz8HTq9A0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jOU4Re2g5QtxpG0RjP3MYBxqz5Z+TtfXq2dz8HTq9A0A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 12, 2023 at 09:05:14PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 8:58 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Dec 04, 2023 at 06:23:02PM +0000, Russell King (Oracle) wrote:
> > > On Tue, Oct 24, 2023 at 08:26:58PM +0200, Rafael J. Wysocki wrote:
> > > > I've gone through the series and there is at least one thing in it
> > > > that concerns me a lot and some others that at least appear to be
> > > > really questionable.
> > > >
> > > > I need more time to send comments which I'm not going to do before the
> > > > 6.7 merge window (sorry), but from what I can say right now, this is
> > > > not looking good.
> > >
> > > Hi Rafael,
> > >
> > > Will you be able to send your comments, so that we can find out what
> > > your other concerns are please? I'm getting questions from interested
> > > parties who want to know what your concerns are.
> > >
> > > Nothing much has changed to the ACPI changes, so I think it's still
> > > valid to have the comments back for this.
> >
> > Hi Rafael,
> >
> > Another gentle prod on this...
> 
> There was a selection of the patches in the series sent separately and
> I believe that some of them have been applied already.
> 
> Can you please send the remaining patches again so it is clear what's
> still outstanding?

I can do tomorrow, thanks. I will re-post as RFC again because it will
depend on the cleanup part that was merged into Greg's tree - and thus
the series isn't standalone (and I'll mention that in the cover
message.)

We need to hear your concerns, which sounded quite damning for the
series, so that if it's possible to save this a plan to address your
concerns can be formulated.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

