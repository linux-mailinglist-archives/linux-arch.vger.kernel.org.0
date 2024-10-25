Return-Path: <linux-arch+bounces-8544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA19B0498
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E091F24377
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953F1FB887;
	Fri, 25 Oct 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I4DKF/WH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OcrFsjgS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I4DKF/WH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OcrFsjgS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701B13A879;
	Fri, 25 Oct 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864376; cv=none; b=l/kW0uUXUu9Tq9KQqxNAQa74pL9104NL9gREGMJ/3ukDzsr+OUdL/Jfm5Tbb3nyrugD9AgjAv4uWxQABTY8xNoQw0dHKYlqAL+V8J+pke2HRHMZPlmElMlPQdj9fTYdgjl9XxVflyT/QIPCAGK/XJJwTvWIo8MV7fj7eNTTE/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864376; c=relaxed/simple;
	bh=TZ4Q18noK/5XG/g0vNsCTv4Y1JPXuVsI5u/4GQ8VABY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ59F9KWMRniVh8s66Z7Ig3NC/AKXpPj5jgX+Mj7cJMud6frRWLAvqdVZJ0GnNh0ptWgBzFzKIKgo55sdCArsVaLdLAd8fFoT8hHIz1ZiRgOBvktTxV52UKpK4aLbY7HXCT1PrIzYVxgBP8Cu02QsHiKmp6uCellLB380p4fZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I4DKF/WH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OcrFsjgS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I4DKF/WH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OcrFsjgS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35B3C1FE29;
	Fri, 25 Oct 2024 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729864372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hVp2BM2ZsW3qQ4gbDue0mRie0l4ERoGo2ToJZjkRdfc=;
	b=I4DKF/WHSXYyxn9maUAO0lJ/ctGVP/AYnNxz0kVTglnATwZNEEoSOqTCtbBsc5AaFrsPf9
	VKd6sqG1NM2MeA6E+cN/uWyVww8IMrVIy3nT11nM9Dsa1XBwO4/K0hxFfVjvZDSMCmsait
	pjmtbTrb+J2Qu5FI9v42Wme88r7a9U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729864372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hVp2BM2ZsW3qQ4gbDue0mRie0l4ERoGo2ToJZjkRdfc=;
	b=OcrFsjgS7DaKcptOnqNC2t0mP+LyutfOa+nfevufxH7FlLbS0QTriUFrEo8D8xNd4ruF6r
	o9Fvj97SA+cuslBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729864372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hVp2BM2ZsW3qQ4gbDue0mRie0l4ERoGo2ToJZjkRdfc=;
	b=I4DKF/WHSXYyxn9maUAO0lJ/ctGVP/AYnNxz0kVTglnATwZNEEoSOqTCtbBsc5AaFrsPf9
	VKd6sqG1NM2MeA6E+cN/uWyVww8IMrVIy3nT11nM9Dsa1XBwO4/K0hxFfVjvZDSMCmsait
	pjmtbTrb+J2Qu5FI9v42Wme88r7a9U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729864372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hVp2BM2ZsW3qQ4gbDue0mRie0l4ERoGo2ToJZjkRdfc=;
	b=OcrFsjgS7DaKcptOnqNC2t0mP+LyutfOa+nfevufxH7FlLbS0QTriUFrEo8D8xNd4ruF6r
	o9Fvj97SA+cuslBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76601132D3;
	Fri, 25 Oct 2024 13:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GXqhG7OiG2eqTwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 25 Oct 2024 13:52:51 +0000
Message-ID: <50017007-d2c3-4964-9cc4-ff26961e3809@suse.de>
Date: Fri, 25 Oct 2024 15:52:51 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] drm: handle HAS_IOPORT dependencies
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
References: <20241024-b4-has_ioport-v9-0-6a6668593f71@linux.ibm.com>
 <20241024-b4-has_ioport-v9-3-6a6668593f71@linux.ibm.com>
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
In-Reply-To: <20241024-b4-has_ioport-v9-3-6a6668593f71@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_TO(0.00)[linux.ibm.com,quicinc.com,holtmann.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,redhat.com,intel.com,linuxfoundation.org,arndb.de,orcam.me.uk];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLykjg6e7ifkwtw7jmpw7b9yio)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 



Am 24.10.24 um 19:54 schrieb Niklas Schnelle:
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
> Acked-by: Lucas De Marchi <lucas.demarchi@intel.com> # xe
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/gma500/Kconfig |  2 +-
>   drivers/gpu/drm/qxl/Kconfig    |  2 +-
>   drivers/gpu/drm/tiny/bochs.c   | 19 ++++++++++++++-----
>   drivers/gpu/drm/tiny/cirrus.c  |  2 ++
>   drivers/gpu/drm/xe/Kconfig     |  2 +-
>   5 files changed, 19 insertions(+), 8 deletions(-)
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
> index ca3f51c2a8fe1a383f8a2479f04b5c0b3fb14e44..17d6927e5e23402786117fd0f99186978956c1c2 100644
> --- a/drivers/gpu/drm/qxl/Kconfig
> +++ b/drivers/gpu/drm/qxl/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_QXL
>   	tristate "QXL virtual GPU"
> -	depends on DRM && PCI && MMU
> +	depends on DRM && PCI && MMU && HAS_IOPORT
>   	select DRM_KMS_HELPER
>   	select DRM_TTM
>   	select DRM_TTM_HELPER
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 31fc5d839e106ea4d5c8fe42d1bfc3c70291e3fb..e738bb85831667f55c436e21e761435def113b9a 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
> +#include <linux/bug.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   
> @@ -95,12 +96,17 @@ struct bochs_device {
>   
>   /* ---------------------------------------------------------------------- */
>   
> +static __always_inline bool bochs_uses_mmio(struct bochs_device *bochs)
> +{
> +	return !IS_ENABLED(CONFIG_HAS_IOPORT) || bochs->mmio;
> +}
> +
>   static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
>   {
>   	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
>   		return;
>   
> -	if (bochs->mmio) {
> +	if (bochs_uses_mmio(bochs)) {
>   		int offset = ioport - 0x3c0 + 0x400;
>   
>   		writeb(val, bochs->mmio + offset);
> @@ -114,7 +120,7 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
>   	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
>   		return 0xff;
>   
> -	if (bochs->mmio) {
> +	if (bochs_uses_mmio(bochs)) {
>   		int offset = ioport - 0x3c0 + 0x400;
>   
>   		return readb(bochs->mmio + offset);
> @@ -127,7 +133,7 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
>   {
>   	u16 ret = 0;
>   
> -	if (bochs->mmio) {
> +	if (bochs_uses_mmio(bochs)) {
>   		int offset = 0x500 + (reg << 1);
>   
>   		ret = readw(bochs->mmio + offset);
> @@ -140,7 +146,7 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
>   
>   static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
>   {
> -	if (bochs->mmio) {
> +	if (bochs_uses_mmio(bochs)) {
>   		int offset = 0x500 + (reg << 1);
>   
>   		writew(val, bochs->mmio + offset);
> @@ -228,7 +234,7 @@ static int bochs_hw_init(struct drm_device *dev)
>   			DRM_ERROR("Cannot map mmio region\n");
>   			return -ENOMEM;
>   		}
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
>   		ioaddr = VBE_DISPI_IOPORT_INDEX;
>   		iosize = 2;
>   		if (!request_region(ioaddr, iosize, "bochs-drm")) {
> @@ -236,6 +242,9 @@ static int bochs_hw_init(struct drm_device *dev)
>   			return -EBUSY;
>   		}
>   		bochs->ioports = 1;
> +	} else {
> +		dev_err(dev->dev, "I/O ports are not supported\n");
> +		return -EIO;
>   	}
>   
>   	id = bochs_dispi_read(bochs, VBE_DISPI_INDEX_ID);
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


