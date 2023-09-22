Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E27AAC9F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjIVI3z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIVI3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 04:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4FABB
        for <linux-arch@vger.kernel.org>; Fri, 22 Sep 2023 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695371343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xUT8FtJmdwXZ1XdzLxxJQDSF0F15AqqVAfggCoYwa/o=;
        b=JQjm1m5Y6NdPRz6o1+yrBAU9eudVCHhMq9LCtrhYC4kEIyOPB2ngin6g7Q1rSkuiUj6wXV
        JJBVMVDmoN0/qwDBLv8lF5mndDx8wylqRtTAOwCuOle9tXPaSZJIzdjNRXPqmK3PAzUJsj
        oruXWwnndZpEeO3LjQDJABQyWqGTM3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-r-K6i8gsMbqUPENJ4TekpQ-1; Fri, 22 Sep 2023 04:29:01 -0400
X-MC-Unique: r-K6i8gsMbqUPENJ4TekpQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-404fa5c1d99so14493365e9.3
        for <linux-arch@vger.kernel.org>; Fri, 22 Sep 2023 01:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371340; x=1695976140;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUT8FtJmdwXZ1XdzLxxJQDSF0F15AqqVAfggCoYwa/o=;
        b=gu5Kc6yu8tdQHM7xEXf/Fa1WR3ReTQ3pWkQmOvWhLJRrTPBFTc/jV+u8UvPIgc0QxL
         4msFTmqBQopN/g5N9ZD8NXK9XLpgHXBHcHb2Ze93LZLyO/ONaZstW8/zckmyVNcmPAmI
         Nn9R8mVKsH93xtYICrq/eBw756eytGj4+jLZjo4HGtJVKdC5F5fO/OwudocPJhJWLzns
         HIxivi4C+OGHPcfZS+b8YXUxaUHrirC+UPmawO+/zcAENfX1O6iYV81joZp1sDtOovzQ
         i5BlDtumIluMTo2tm7+t8pH+YHJqxtGZwH/Nfruu8Jm9E/iYNjTHKoo3XKBJymQOjutj
         ymDg==
X-Gm-Message-State: AOJu0YzxTvrAlbGl6ZNd2oipQTokjLtb8gJLfPegyfI0w7lljYspuZY7
        RaaFUhOLavfbZFiWK0kEtVu0GRmiB5VVjk7GcigIEeymPZFFDReRRRfJO395+KiaOZ/wgzFQQTM
        BAyOYNZWVipp2Hd19Pci8cQ==
X-Received: by 2002:a05:600c:1e0b:b0:405:4002:825a with SMTP id ay11-20020a05600c1e0b00b004054002825amr568123wmb.13.1695371340724;
        Fri, 22 Sep 2023 01:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrR9BIVVw8Y2WgBOUvl/XqDvvu2Yb9s8zAvf4Vn3nfvNA1NNc3OCwyRPJ1UY+bCHomzJ5jcg==
X-Received: by 2002:a05:600c:1e0b:b0:405:4002:825a with SMTP id ay11-20020a05600c1e0b00b004054002825amr568100wmb.13.1695371340371;
        Fri, 22 Sep 2023 01:29:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c21ce00b003fefcbe7fa8sm4004012wmj.28.2023.09.22.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:29:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, arnd@arndb.de,
        deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 2/5] fbdev: Replace fb_pgprotect() with
 pgprot_framebuffer()
In-Reply-To: <20230922080636.26762-3-tzimmermann@suse.de>
References: <20230922080636.26762-1-tzimmermann@suse.de>
 <20230922080636.26762-3-tzimmermann@suse.de>
Date:   Fri, 22 Sep 2023 10:28:59 +0200
Message-ID: <87wmwik3w4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Rename the fbdev mmap helper fb_pgprotect() to pgprot_framebuffer().
> The helper sets VMA page-access flags for framebuffers in device I/O
> memory.
>
> Also clean up the helper's parameters and return value. Instead of
> the VMA instance, pass the individial parameters separately: existing
> page-access flags, the VMAs start and end addresses and the offset
> in the underlying device memory rsp file. Return the new page-access
> flags. These changes align pgprot_framebuffer() with other pgprot_()
> functions.
>
> v4:
> 	* fix commit message (Christophe)
> v3:
> 	* rename fb_pgprotect() to pgprot_framebuffer() (Arnd)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

