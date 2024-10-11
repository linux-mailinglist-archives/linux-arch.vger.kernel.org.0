Return-Path: <linux-arch+bounces-8016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64258999C71
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 08:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186B31F228F5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD9207217;
	Fri, 11 Oct 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bF4rdRfG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0E192D77;
	Fri, 11 Oct 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728626964; cv=none; b=b3LZ/3CWf+DeqHas05oKQ9Mk6q4zxa0gtQhU5eSJ3j+OEOfJsHiAJUcbkpcvjGusuhakLaHrRUrQeSqLoJuuGbIe1TitDloxqnNTSZj1IrDYqNFpphqWno3Ype6pPO8dyJFSRbOHSMY3Mr8qM2dHZGPtZFagySCBoVK4+OzyuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728626964; c=relaxed/simple;
	bh=i9cYUz3cSkHkjlbjXX2TL+CxfIfYsIh3kS/FujNH0ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJTGtbH4d87CKPj1RaSN0cbnvQvOUHm1OgBnEffI1UGeDsY2sXtzAaY62nNW67fQ04fev7TbKZ/43ILgKQbd4hwdu9ZZQ3vSwv83DUAk1GsxuxePAT72RxEus00DuuRXX41NUPFiGg9XHHG6+kG+ZPhymGnGfbCIQ9q1dAo/KrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bF4rdRfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B52C4CEC3;
	Fri, 11 Oct 2024 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728626963;
	bh=i9cYUz3cSkHkjlbjXX2TL+CxfIfYsIh3kS/FujNH0ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bF4rdRfGhj7EVWEvLjIfvY+4Raq2vEZe+yssbLN3OZ7fW7bmvDXav08gT+gBmnGSN
	 +kmbBAOFkJtlYBrDlPTHGKAwQ7ax+wesMXi2/XL+kUHhYtiJRprpUQREwCqcUwTNpH
	 tw+1wq1CQATrSDYV/rW/qsI+U6tk1p7cmzHdYaBs=
Date: Fri, 11 Oct 2024 08:09:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v8 4/5] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <2024101112-tile-cupping-3431@gregkh>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
 <20241008-b4-has_ioport-v8-4-793e68aeadda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-b4-has_ioport-v8-4-793e68aeadda@linux.ibm.com>

On Tue, Oct 08, 2024 at 02:39:45PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them unconditionally. Some 8250 serial drivers support
> MMIO only use, so fence only the parts requiring I/O ports and print an
> error message if a device can't be supported with the current
> configuration.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

