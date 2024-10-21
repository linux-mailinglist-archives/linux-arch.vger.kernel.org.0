Return-Path: <linux-arch+bounces-8332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B89A5DA5
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D081C2127B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96301E0E0C;
	Mon, 21 Oct 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gu3P+rke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsbbZXLH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gu3P+rke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsbbZXLH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578221D12F0;
	Mon, 21 Oct 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497168; cv=none; b=eaH+y9FqR+Wauyl2vSeXNPOOOs7A7bNiVNNGtV44vMp9lWLY3R5SvWUr/qHFPD9m8PzNb8hymrByAJS9j5Ogj9syEEuuRh4EHE2RfoQhxsIMMpDlW27LjYGZH+Yhe0uad2FBbq2WwhOv/n9kzPgLeRbb1sONdVO0uBWnflCOLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497168; c=relaxed/simple;
	bh=pHF/oNXziLvw1gVrt+PZXgx884BvfRhHiXxgowYHu8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idptleOnJSvLlyFtktQ4GxKxy3Pr2qEU/b02v4GaQsTfGxUTN33rs0X/EShjiSfRyJ3BrZbxJpMahoF8jVk9KBfokzRVVdE0ddXMo+OGZ7KqWJIf6jgLVkf6SMB/ksouUV9e9WymlmHvIh5wBEh6sV/Mc1RUaH7mqE8/RuktHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gu3P+rke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsbbZXLH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gu3P+rke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BsbbZXLH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E71D21C8B;
	Mon, 21 Oct 2024 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729497164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bXWhUoNB23Y9fn9mmx7c9jTXn4fLCljjY288raDMPls=;
	b=gu3P+rke6FChZ+iL9iQ+lLmlJ6Ea+1DKxZ09E0WYsi+YXzqU2jfPvc8nepMXe7WlQkEHb/
	cRWORXyGWetASL/F+MRr05w8KEsH+sOeZM00efOJXI2E+uYLptGTsEm0aBKdtVv/Q2FwRw
	Pe2UlWBaX1U78BEfeKWx3mkspGFO3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729497164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bXWhUoNB23Y9fn9mmx7c9jTXn4fLCljjY288raDMPls=;
	b=BsbbZXLHFFBenHj04BVjnKQqAydVYkEXeRJZraeFiS0+UAY9sFs7MSQRVxTpTyCCP4J0cr
	r0nVCkV8dS9dXkDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gu3P+rke;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BsbbZXLH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729497164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bXWhUoNB23Y9fn9mmx7c9jTXn4fLCljjY288raDMPls=;
	b=gu3P+rke6FChZ+iL9iQ+lLmlJ6Ea+1DKxZ09E0WYsi+YXzqU2jfPvc8nepMXe7WlQkEHb/
	cRWORXyGWetASL/F+MRr05w8KEsH+sOeZM00efOJXI2E+uYLptGTsEm0aBKdtVv/Q2FwRw
	Pe2UlWBaX1U78BEfeKWx3mkspGFO3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729497164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bXWhUoNB23Y9fn9mmx7c9jTXn4fLCljjY288raDMPls=;
	b=BsbbZXLHFFBenHj04BVjnKQqAydVYkEXeRJZraeFiS0+UAY9sFs7MSQRVxTpTyCCP4J0cr
	r0nVCkV8dS9dXkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE3FD139E0;
	Mon, 21 Oct 2024 07:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qnn/MEsIFmdPVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 21 Oct 2024 07:52:43 +0000
Message-ID: <64cc9c8f-fff3-4845-bb32-d7f1046ef619@suse.de>
Date: Mon, 21 Oct 2024 09:52:43 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] drm: handle HAS_IOPORT dependencies
To: Niklas Schnelle <schnelle@linux.ibm.com>, Brian Cain <bcain@quicinc.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
 linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
 <20241008-b4-has_ioport-v8-3-793e68aeadda@linux.ibm.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20241008-b4-has_ioport-v8-3-793e68aeadda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8E71D21C8B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linux.ibm.com,quicinc.com,holtmann.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,redhat.com,intel.com,linuxfoundation.org,arndb.de,orcam.me.uk];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi

Am 08.10.24 um 14:39 schrieb Niklas Schnelle:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them. In the bochs driver there is optional MMIO support
> detected at runtime, warn if this isn't taken when HAS_IOPORT is not
> defined.
>
> There is also a direct and hard coded use in cirrus.c which according to
> the comment is only necessary during resume.  Let's just skip this as
> for example s390 which doesn't have I/O port support also doesen't
> support suspend/resume.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I feel like I reviewed this before, but can't find it.

> ---
>   drivers/gpu/drm/gma500/Kconfig |  2 +-
>   drivers/gpu/drm/qxl/Kconfig    |  1 +
>   drivers/gpu/drm/tiny/bochs.c   | 17 +++++++++++++++++
>   drivers/gpu/drm/tiny/cirrus.c  |  2 ++
>   drivers/gpu/drm/xe/Kconfig     |  2 +-
>   5 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> index efb4a2dd2f80885cb59c925d09401002278d7d61..23b7c14de5e29238ece939d5822d8a9ffc4675cc 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_GMA500
>   	tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> -	depends on DRM && PCI && X86 && MMU
> +	depends on DRM && PCI && X86 && MMU && HAS_IOPORT
>   	select DRM_KMS_HELPER
>   	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
>   	select I2C
> diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
> index ca3f51c2a8fe1a383f8a2479f04b5c0b3fb14e44..d0e0d440c8d96564cb7b8ffd2385c44fc43f873d 100644
> --- a/drivers/gpu/drm/qxl/Kconfig
> +++ b/drivers/gpu/drm/qxl/Kconfig
> @@ -2,6 +2,7 @@
>   config DRM_QXL
>   	tristate "QXL virtual GPU"
>   	depends on DRM && PCI && MMU
> +	depends on HAS_IOPORT

Is there a difference between this style (multiple 'depends on') and the 
one used for gma500 (&& && &&)?

>   	select DRM_KMS_HELPER
>   	select DRM_TTM
>   	select DRM_TTM_HELPER
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 31fc5d839e106ea4d5c8fe42d1bfc3c70291e3fb..0ed78d3d5774778f91de972ac27056938036e722 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -2,6 +2,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/bug.h>

Alphabetic sorting please.

>   
>   #include <drm/drm_aperture.h>
>   #include <drm/drm_atomic_helper.h>
> @@ -105,7 +106,9 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
>   
>   		writeb(val, bochs->mmio + offset);
>   	} else {
> +#ifdef CONFIG_HAS_IOPORT
>   		outb(val, ioport);
> +#endif

Could you provide empty defines for the out() interfaces at the top of 
the file?

>   	}
>   }
>   
> @@ -119,7 +122,11 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
>   
>   		return readb(bochs->mmio + offset);
>   	} else {
> +#ifdef CONFIG_HAS_IOPORT
>   		return inb(ioport);
> +#else
> +		return 0xff;
> +#endif

And the in() interfaces could be defined to 0xff[ff].

I assume that you don't want to provide such empty macros in the 
kernel's io.h header?

>   	}
>   }
>   
> @@ -132,8 +139,12 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
>   
>   		ret = readw(bochs->mmio + offset);
>   	} else {
> +#ifdef CONFIG_HAS_IOPORT
>   		outw(reg, VBE_DISPI_IOPORT_INDEX);
>   		ret = inw(VBE_DISPI_IOPORT_DATA);
> +#else
> +		ret = 0xffff;
> +#endif
>   	}
>   	return ret;
>   }
> @@ -145,8 +156,10 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
>   
>   		writew(val, bochs->mmio + offset);
>   	} else {
> +#ifdef CONFIG_HAS_IOPORT
>   		outw(reg, VBE_DISPI_IOPORT_INDEX);
>   		outw(val, VBE_DISPI_IOPORT_DATA);
> +#endif
>   	}
>   }
>   
> @@ -229,6 +242,10 @@ static int bochs_hw_init(struct drm_device *dev)
>   			return -ENOMEM;
>   		}
>   	} else {
> +		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> +			DRM_ERROR("I/O ports are not supported\n");
> +			return -EIO;
> +		}

It would be nicer to use an "} else if(IOPORT) {" here and put the 
"return -EIO" into a trailing else branch.

If you want to add an error message, please don't use DRM_ERROR(). In 
this case, dev_err(dev->dev, "...\n") seems appropriate.

Best regards
Thomas

>   		ioaddr = VBE_DISPI_IOPORT_INDEX;
>   		iosize = 2;
>   		if (!request_region(ioaddr, iosize, "bochs-drm")) {
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index 751326e3d9c374baf72115492aeefff2b73869f0..e31e1df029ab0272c4a1ff0ab3eb026ca679b560 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -509,8 +509,10 @@ static void cirrus_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>   
>   	cirrus_mode_set(cirrus, &crtc_state->mode);
>   
> +#ifdef CONFIG_HAS_IOPORT
>   	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
>   	outb(VGA_AR_ENABLE_DISPLAY, VGA_ATT_W);
> +#endif
>   
>   	drm_dev_exit(idx);
>   }
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 7bbe46a98ff1f449bc2af30686585a00e9e8af93..116f58774135fc3a9f37d6d72d41340f5c812297 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -49,7 +49,7 @@ config DRM_XE
>   
>   config DRM_XE_DISPLAY
>   	bool "Enable display support"
> -	depends on DRM_XE && DRM_XE=m
> +	depends on DRM_XE && DRM_XE=m && HAS_IOPORT
>   	select FB_IOMEM_HELPERS
>   	select I2C
>   	select I2C_ALGOBIT
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


