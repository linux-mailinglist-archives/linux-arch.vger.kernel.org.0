Return-Path: <linux-arch+bounces-8063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431999B9D8
	for <lists+linux-arch@lfdr.de>; Sun, 13 Oct 2024 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207592812B0
	for <lists+linux-arch@lfdr.de>; Sun, 13 Oct 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682A146A60;
	Sun, 13 Oct 2024 14:53:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D214658D;
	Sun, 13 Oct 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831231; cv=none; b=hqiJmPDQWWP5AuJQSx4yMcjMj4bHnsqVYT9m+Glq/MXpbfszwQMhJ+miBVHs/ykLtQFIlCEZtdGESe65NActfgg+ULLZRx4Ik3U7Ex4btqCsZYnyfCUhRCwDQs29Ne4Rl2ZUU47dHHjbjLdWkIexTh27nYs+lsuSK3f4rHvlV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831231; c=relaxed/simple;
	bh=ZPrqktIBvEbSoUkJg5cCHO2AotiBkdlWwb2MZNJ+MOE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W8LYT7x5XIqW1iN+bNezrPlLaEP3eSZTqke1NoPgo9sLYlN0woe9DvEL0S0Rz7cIREr0/sokmYAIu2/J/f48Je2fADLe2C1QFvaIvQEjpHWZ5JAKF3VB2bSBrcveqwWyDqMwebSDBJoeY6Jg53OcErRsLwg37U7kxo0n+y31UBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D39F592009D; Sun, 13 Oct 2024 16:53:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CF7EB92009C;
	Sun, 13 Oct 2024 15:53:48 +0100 (BST)
Date: Sun, 13 Oct 2024 15:53:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
    Gerd Hoffmann <kraxel@redhat.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, 
    linux-hexagon@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
    dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
    spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, 
    Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v8 4/5] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <20241008-b4-has_ioport-v8-4-793e68aeadda@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2410131553340.40463@angie.orcam.me.uk>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com> <20241008-b4-has_ioport-v8-4-793e68aeadda@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Oct 2024, Niklas Schnelle wrote:

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

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

