Return-Path: <linux-arch+bounces-9911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0EA1D182
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 08:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E66D166505
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4731FC7EE;
	Mon, 27 Jan 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PbuWr2O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vmEV+QYj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FoU8vOBB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bjc1CoH7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B51FCCF3;
	Mon, 27 Jan 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963077; cv=none; b=h5/NT9fE0wyBeR97dwJMeTvm27Zs+bZQ4xsfvJ3SdOo5YzYHw1PQ1dVBm+euDk0BUHAYjLZZVWItVBj9AP5CELMlM8cDacS+8WQIhgP4sgtECvABhsmP3bOVIP32ESv5Js+pXXbmn2ZXRbwSkBAXxRUcc9Dl13+WC+gpmtGzsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963077; c=relaxed/simple;
	bh=1+TQ2PM71CF8SXu1hsfhK4fmIT0/a7AtM9fEu/4E56s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGELP2RQ0G559HHvWVmNTGtA+Ku3QgaFNz7I877qHzQvNcjXO4OdWPIlFTCqHE/aZr9zvGz/B9WWEfA3SarUVuJOJfgXWJUCprpspUvssSMYgJTIsMqqUfXdRZzs9z00Y4eDC9Id4cLZoJPYHv8TiD6rm4oPYu0QrWVkdJVvNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PbuWr2O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vmEV+QYj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FoU8vOBB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bjc1CoH7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E46E21151;
	Mon, 27 Jan 2025 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737963073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IrjE7Md0yLO+y3LEKxDOvKOZsXpSU/ntoaUMfI9RqYw=;
	b=1PbuWr2OSp32uKi+VGAls9q5MUM+dnM6CbfTpc6SeFmih89rMuENSrn4qS3weLXhK7ZDTN
	XeT1RK6/+OgQE8gPT37bPol3lzoSZ2Rld7JYbvUGwZ/GJ0qwuBend5Vtq0lr5lrIvHoxqS
	wYsMqPDptkGt6q5CkgN/Dfa0QpKDOu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737963073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IrjE7Md0yLO+y3LEKxDOvKOZsXpSU/ntoaUMfI9RqYw=;
	b=vmEV+QYjSDAPx9TIENV2/os0QSAL1CFRNBtlBvFmOQOmbiTFwfXSv4xBFAgdSf4T9r2IiI
	Gwjzfl2AX0L+TICg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FoU8vOBB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bjc1CoH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737963071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IrjE7Md0yLO+y3LEKxDOvKOZsXpSU/ntoaUMfI9RqYw=;
	b=FoU8vOBBpjtTEdEAZTq6f/Ldi7fYVyh6GGAzvLSii2lLGSBD6bI9yNkLk/9kUIkWKdlU+f
	lP4A9spC9aD8UE9Vql6xmlETSOrN17TMF1FTVpH886YSckxVknk2yV4l1pkIwr3Uye6ZzI
	OInVdHFj8w9C+wYuV5K6FIMVvch/Rfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737963071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IrjE7Md0yLO+y3LEKxDOvKOZsXpSU/ntoaUMfI9RqYw=;
	b=Bjc1CoH7MtEi4oMNDwhQsBOrcWoQdlmvsSGs48yzjRNkB4ucyK0ZGSZ8K1nPNrufFzrCtt
	SgHm9VrcIz7T+WCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C48137C0;
	Mon, 27 Jan 2025 07:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i+WWNj42l2ctKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Jan 2025 07:31:10 +0000
Message-ID: <4a1c7ab2-66b8-49ec-9662-6827c811ab69@suse.de>
Date: Mon, 27 Jan 2025 08:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: Align host mapping request to maximum
 platform page size
To: fnkl.kernel@gmail.com, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 "arnd@arndb.de" <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <20250125-virtgpu-mixed-page-size-v2-1-c40c555cf276@gmail.com>
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
In-Reply-To: <20250125-virtgpu-mixed-page-size-v2-1-c40c555cf276@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4E46E21151
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,chromium.org,linux.intel.com,kernel.org,ffwll.ch,arndb.de];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi


Am 25.01.25 um 22:08 schrieb Sasha Finkelstein via B4 Relay:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> This allows running different page sizes between host and guest on
> platforms that support mixed page sizes.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
> Changes in v2:
> - Aligned all object sizes to MAX_PAGE_SIZE too.
> - Link to v1: https://lore.kernel.org/r/20250109-virtgpu-mixed-page-size-v1-1-c8fe1e1859f3@gmail.com
> ---
>   drivers/gpu/drm/virtio/virtgpu_drv.h    | 6 ++++++
>   drivers/gpu/drm/virtio/virtgpu_gem.c    | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_vram.c   | 4 ++--
>   5 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 64c236169db88acd6ba9afd20a1ab16c667490c4..b73844d6535e45402dc46898035eaa7492de935d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -61,6 +61,12 @@
>   /* See virtio_gpu_ctx_create. One additional character for NULL terminator. */
>   #define DEBUG_NAME_MAX_LEN 65
>   
> +#if defined(__powerpc64__) || defined(__aarch64__) || defined(__mips__) || defined(__loongarch__)
> +#define MAX_PAGE_SIZE SZ_64K
> +#else
> +#define MAX_PAGE_SIZE PAGE_SIZE
> +#endif

This is per-architecture code and does not belong in a DRM driver.

Best regards
Thomas

> +
>   struct virtio_gpu_object_params {
>   	unsigned long size;
>   	bool dumb;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 7db48d17ee3a8a9c638a8c6f9e58f35bd004b453..8e625ccae308f46b11a390a0987fd5ea55ccbf8d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -73,7 +73,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>   
>   	pitch = args->width * 4;
>   	args->size = pitch * args->height;
> -	args->size = ALIGN(args->size, PAGE_SIZE);
> +	args->size = ALIGN(args->size, MAX_PAGE_SIZE);
>   
>   	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
>   	params.width = args->width;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index e4f76f31555049369000a50c0cb1d5edab68536b..e39ae008ac5f734ec52e9703413958b4ea4be7d6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -167,7 +167,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>   	params.size = rc->size;
>   	/* allocate a single page size object */
>   	if (params.size == 0)
> -		params.size = PAGE_SIZE;
> +		params.size = MAX_PAGE_SIZE;
>   
>   	fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
>   	if (!fence)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index c7e74cf130221bbed3aa447e416065b03bf3e2b4..5aab82028293b7d73bcc4e686e7e2ecba6108b7b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -190,7 +190,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>   
>   	*bo_ptr = NULL;
>   
> -	params->size = roundup(params->size, PAGE_SIZE);
> +	params->size = roundup(params->size, MAX_PAGE_SIZE);
>   	shmem_obj = drm_gem_shmem_create(vgdev->ddev, params->size);
>   	if (IS_ERR(shmem_obj))
>   		return PTR_ERR(shmem_obj);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
> index 25df81c027837c248a746e41856b5aa7e216b8d5..18e773b036f7c8190d4e20ad3f2c85c36e7e295c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -150,8 +150,8 @@ static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
>   		return -EINVAL;
>   
>   	spin_lock(&vgdev->host_visible_lock);
> -	ret = drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_node,
> -				 bo->base.base.size);
> +	ret = drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram->vram_node,
> +					 bo->base.base.size, MAX_PAGE_SIZE, 0, 0);
>   	spin_unlock(&vgdev->host_visible_lock);
>   
>   	if (ret)
>
> ---
> base-commit: 643e2e259c2b25a2af0ae4c23c6e16586d9fd19c
> change-id: 20250109-virtgpu-mixed-page-size-282b8f4a02fc
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


