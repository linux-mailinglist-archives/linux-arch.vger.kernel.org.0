Return-Path: <linux-arch+bounces-12955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A701FB12041
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D857D566A50
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE7274FC8;
	Fri, 25 Jul 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdPKwstE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83BD2459F9;
	Fri, 25 Jul 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454467; cv=none; b=gAGiZ09O5sZkjmSZiKw2uahXfXjfMIqC1H1yF/Xj4HBzoxfAm445AjIQJE7aapxUhzp31Yxii8tH7+esb8X+q9aXXU5isj0XfltK5Io8sGLIr69o1QeY4XfWlYpaKvPpU6L9O78r7g58xJ6OYC+5Gt+TefrflFpvbq0byQvku0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454467; c=relaxed/simple;
	bh=sGTl1eo91jSnILZM8TuIOEpIUOHHIl79Ky9Pwbzq9nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rObG0m9abPzgrzteDEAGsbwUOBrHP/py1UJhvqTBy0DXf/CIGyw1YK6rsmOKIwMCBtslt3yw0CPwwXLKBmzJ6wwaUQhf/EQsWB/kAUkuk3WPUqMtN5sEhZKzzno17Vg2V5ctebEe/Se0jDFmHem6p6vlGlhoD0Y+juO7f85XWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdPKwstE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23f8bcce78dso25893455ad.3;
        Fri, 25 Jul 2025 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753454465; x=1754059265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKgsPP4zPK7SJVV2IQKnHzdNSGAtC3gfZtrlCNS6aF4=;
        b=gdPKwstEgeM9pyTh/0lxmg0T2DJI9Zvhzvh87LuMm44ao2R8B4cU6MTnk1jPTxaulZ
         5mVbCeY/kRfY6dx6kcVuIG2s+kD2TfKDmhHPPBGi7tP5f0PRWlUhlkczW9auh9UOfr6i
         Vmej1/Irck9tHecjrx8lTe3XE/vH+zedwlFQ255cXywbuXsI9tJiCSCzutkfKqpfQy8v
         fqvwYfo2e/m0BoiX9asJE/iTJ6GZKSm/cH7z3CJDYPkowl6G/hFu6CfQdQ+bHTGxwFQ0
         OW2yPOMGS24mlIC9tx7XRb186aMoe7x6i281Y4IMoWa/l+4tFXhCKBnKAs68ZzHXrFD1
         OtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753454465; x=1754059265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKgsPP4zPK7SJVV2IQKnHzdNSGAtC3gfZtrlCNS6aF4=;
        b=nuMEUi6nlwCBoiHp17oNSSnM61D2SNaHhqSxArpUOaBjb5ZyUtTW3bNXHdsFK+U3+V
         gzfeCNJ8sVWm6X4SymHq2USsKs+j7vAS+IPk4aD6k3qb+DJwH5REnzwegdoc+hL771tW
         qVEAiYUfdWQ1P3OGP4iry0/BsBCRHkJhLId67LKb+EyyWN1O5oMDMnbkPX2Ru3RDARj5
         890D41vWqHGyZOYn6HINmoGZGXPC5vOpMs4YNs4dJ7Zf7WnGenR8vkHEVKTqnmXitKjz
         H6WqjNzlfNe8qT4//63sSQ9FC/Qr3DCD1tdpAzPyCVAx3rxJqowe0YE4TOwiCQP2fZss
         Ov7w==
X-Forwarded-Encrypted: i=1; AJvYcCUAaw8ZZIv/WK47HLgGMzzD8uySthhoZhpGx4yaFEQwUQjSiIoXKg8yNMh7x1TyC+EyDykKxAfPrn+PW1FO@vger.kernel.org, AJvYcCVm5a9++GO1l5jpom5IWR4faQd1qO58/eaON4W/F9JvnleRpmVq1XGGBbNFLKeTI1x8UTaBBt7nSjskmtAI@vger.kernel.org, AJvYcCWC0UClaNSD4AaHebXCQ+d8rSuVUa+Aa40l9sIH7ecmM7/hRUDj9ymMkLAFmW7SveYPb/2015oHaX55@vger.kernel.org, AJvYcCWFKHSOlZiBG/9MgH1M79BceBCQGOT6vp6NbZmornVkX31K7ML1WRGEU4+OR3hMcOV2vb4vPjDb6mK9@vger.kernel.org
X-Gm-Message-State: AOJu0YyesOr8msMF4habjoyOMdRXf1zZCTgRgp9ZXYboP2B4YSU4pNM8
	CCcYOFxOGfPrduip+eTc9rhrdU2hHp9SWYYL1ZqJ36LzP/FbkyP9Kf+5/MBA1uuZu5H80l1q87I
	N/9Qb3UrHq6VTXHc9hymoov5yzZ68jY3M9Qim
X-Gm-Gg: ASbGncua5ZftMoUxfhrCa0SCSNpEoLRp3bKTj53l0Tv5Rbm0moKsKUFZyftJzS8is+V
	XEGZiThEAm5a0GkPwq3dCikN+h+R+UThI0//YGYpMlcUzB4zLci+7PodarjNHu3gANf7/OzFK/M
	wwJXAHeNtw8KGqtWlTJ9vMrYaSYJsq1ZLRjy0lchU+di2TpqbUD1AN35a2k8bsMffpoptpHKePX
	qTbSxv0CfrBLks=
X-Google-Smtp-Source: AGHT+IFePPdNf5mTv+w/Kxg+8bWSXr5Vh2E5/lMd3Me7vurN8JkxVvIEE7J6nQMlYnnWtLKMSDKRAdRJQJFR2RNXDDE=
X-Received: by 2002:a17:902:c751:b0:234:ed31:fc99 with SMTP id
 d9443c01a7336-23fb309b836mr26836565ad.21.1753454465068; Fri, 25 Jul 2025
 07:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-13-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-13-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 22:40:29 +0800
X-Gm-Features: Ac12FXxEB_FL3_rT6cHSVkdJsOhCBETxNq543NIYn_bXKIfHCNGG5wd0r0RZbmw
Message-ID: <CAMvTesBiSOsxywS+JxAB+oAh9i1UEbngAXeZJdi7SWqm9pAd9A@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 12/16] Drivers: hv: Allocate encrypted
 buffers when requested
To: Roman Kisel <romank@linux.microsoft.com>
Cc: alok.a.tiwari@oracle.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kys@microsoft.com, mhklinux@outlook.com, mingo@redhat.com, 
	rdunlap@infradead.org, tglx@linutronix.de, Tianyu.Lan@microsoft.com, 
	wei.liu@kernel.org, linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com, 
	benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:28=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> Confidential VMBus is built around using buffers not shared with
> the host.
>
> Support allocating encrypted buffers when requested.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

>  drivers/hv/channel.c      | 49 +++++++++++++++++++++++----------------
>  drivers/hv/hyperv_vmbus.h |  3 ++-
>  drivers/hv/ring_buffer.c  |  5 ++--
>  3 files changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 35f26fa1ffe7..051eeba800f2 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -443,20 +443,23 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel *channel,
>                 return ret;
>         }
>
> -       /*
> -        * Set the "decrypted" flag to true for the set_memory_decrypted(=
)
> -        * success case. In the failure case, the encryption state of the
> -        * memory is unknown. Leave "decrypted" as true to ensure the
> -        * memory will be leaked instead of going back on the free list.
> -        */
> -       gpadl->decrypted =3D true;
> -       ret =3D set_memory_decrypted((unsigned long)kbuffer,
> -                                  PFN_UP(size));
> -       if (ret) {
> -               dev_warn(&channel->device_obj->device,
> -                        "Failed to set host visibility for new GPADL %d.=
\n",
> -                        ret);
> -               return ret;
> +       gpadl->decrypted =3D !((channel->co_external_memory && type =3D=
=3D HV_GPADL_BUFFER) ||
> +               (channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> +       if (gpadl->decrypted) {
> +               /*
> +                * The "decrypted" flag being true assumes that set_memor=
y_decrypted() succeeds.
> +                * But if it fails, the encryption state of the memory is=
 unknown. In that case,
> +                * leave "decrypted" as true to ensure the memory is leak=
ed instead of going back
> +                * on the free list.
> +                */
> +               ret =3D set_memory_decrypted((unsigned long)kbuffer,
> +                                       PFN_UP(size));
> +               if (ret) {
> +                       dev_warn(&channel->device_obj->device,
> +                               "Failed to set host visibility for new GP=
ADL %d.\n",
> +                               ret);
> +                       return ret;
> +               }
>         }
>
>         init_completion(&msginfo->waitevent);
> @@ -544,8 +547,10 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>                  * left as true so the memory is leaked instead of being
>                  * put back on the free list.
>                  */
> -               if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(=
size)))
> -                       gpadl->decrypted =3D false;
> +               if (gpadl->decrypted) {
> +                       if (!set_memory_encrypted((unsigned long)kbuffer,=
 PFN_UP(size)))
> +                               gpadl->decrypted =3D false;
> +               }
>         }
>
>         return ret;
> @@ -676,12 +681,13 @@ static int __vmbus_open(struct vmbus_channel *newch=
annel,
>                 goto error_clean_ring;
>
>         err =3D hv_ringbuffer_init(&newchannel->outbound,
> -                                page, send_pages, 0);
> +                                page, send_pages, 0, newchannel->co_ring=
_buffer);
>         if (err)
>                 goto error_free_gpadl;
>
>         err =3D hv_ringbuffer_init(&newchannel->inbound, &page[send_pages=
],
> -                                recv_pages, newchannel->max_pkt_size);
> +                                recv_pages, newchannel->max_pkt_size,
> +                                newchannel->co_ring_buffer);
>         if (err)
>                 goto error_free_gpadl;
>
> @@ -862,8 +868,11 @@ int vmbus_teardown_gpadl(struct vmbus_channel *chann=
el, struct vmbus_gpadl *gpad
>
>         kfree(info);
>
> -       ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
> -                                  PFN_UP(gpadl->size));
> +       if (gpadl->decrypted)
> +               ret =3D set_memory_encrypted((unsigned long)gpadl->buffer=
,
> +                                       PFN_UP(gpadl->size));
> +       else
> +               ret =3D 0;
>         if (ret)
>                 pr_warn("Fail to set mem host visibility in GPADL teardow=
n %d.\n", ret);
>
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 2873703d08a9..beae68a70939 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -200,7 +200,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
>  void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -                      struct page *pages, u32 pagecnt, u32 max_pkt_size)=
;
> +                      struct page *pages, u32 pagecnt, u32 max_pkt_size,
> +                          bool confidential);
>
>  void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
>
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 3c9b02471760..05c2cd42fc75 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -183,7 +183,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *cha=
nnel)
>
>  /* Initialize the ring buffer. */
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -                      struct page *pages, u32 page_cnt, u32 max_pkt_size=
)
> +                      struct page *pages, u32 page_cnt, u32 max_pkt_size=
,
> +                          bool confidential)
>  {
>         struct page **pages_wraparound;
>         int i;
> @@ -207,7 +208,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ri=
ng_info,
>
>         ring_info->ring_buffer =3D (struct hv_ring_buffer *)
>                 vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -                       pgprot_decrypted(PAGE_KERNEL));
> +                       confidential ? PAGE_KERNEL : pgprot_decrypted(PAG=
E_KERNEL));
>
>         kfree(pages_wraparound);
>         if (!ring_info->ring_buffer)
> --
> 2.43.0
>
>


--=20
Thanks
Tianyu Lan

