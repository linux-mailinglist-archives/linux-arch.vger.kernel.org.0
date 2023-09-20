Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E577A7577
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjITILT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Sep 2023 04:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjITILR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Sep 2023 04:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE4AC
        for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2023 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695197381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUFr8wXK8O4RymSbY1nra3xh487ahU0WWNS0q+EozOI=;
        b=cZw9MAO/FcFnZh/YiCPqOFpRj2rCyX2RsOemK+2vaLaMFb0Wu8mzwKMzLVxGm29okoWQVG
        SkEfU37DssycvC5aRN3SI6NWuDrNFSPNEOXhHo4rvzLdpsGrsgeCCmv3lxG33uval6NTvj
        G7r3dbjR0RWZqiRjE8SH/XD1CzAFelQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-C8IVNmQzNveTBdkAkQYqqg-1; Wed, 20 Sep 2023 04:09:39 -0400
X-MC-Unique: C8IVNmQzNveTBdkAkQYqqg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd0fa4d08cso48486085e9.1
        for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2023 01:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695197378; x=1695802178;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUFr8wXK8O4RymSbY1nra3xh487ahU0WWNS0q+EozOI=;
        b=pqfpQrT4VjA5JrNMrfDvuMX17AlQVtr/T0XmJ94aBa0GanhJW1ltDdvlEFEIFnJDJX
         arxo53pqdF1yptoQhcaYOVZYI+Qj/ZqVDIL34FOi0Fg6VyT6oAZaoFuKk0mwzwxO8UJ+
         HnrEoQ5CEY1aXmuWjfk1SSrZAi/55ngkPMDNfwvwcvOJnLE7KuNgXEmmVbTSjZrpAFn/
         +PPMhOEWgbE2q/bMozwa28d/aSUEnrj3b8mmZBfwgihINZcZR/ihmkIiZmC1KLoCAmzK
         CAwxUBysQ+m+BupTzwZfk6UeUd3cWrtPzc/brRbrK73ezRIuNFVDRxcq6pObT/6NsD4R
         wupA==
X-Gm-Message-State: AOJu0YwyfZn988CBYx6lzTvmbgTr+D/TU1DI44ImJ8Ywnxal+KyfWEe9
        /oIrscNZR7KAoUxH9kXdgVqg8KOy8/BD/gGD2F2Ccq4uiPuFaEQKLE/3pvqRfpJjKOJT3tlYbWR
        XlSAFNPi0sLL+8eKQYVS00w==
X-Received: by 2002:a1c:771a:0:b0:401:bf56:8ba0 with SMTP id t26-20020a1c771a000000b00401bf568ba0mr1546094wmi.28.1695197378553;
        Wed, 20 Sep 2023 01:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysZz6FM59YTt5tU+tK8YwrLHrBxcEDjY1ArDkjh6Nbe/7xpyZCpKNOycMqjW9MlKxyQeQmA==
X-Received: by 2002:a1c:771a:0:b0:401:bf56:8ba0 with SMTP id t26-20020a1c771a000000b00401bf568ba0mr1546080wmi.28.1695197378265;
        Wed, 20 Sep 2023 01:09:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c22da00b003fedcd02e2asm1223759wmg.35.2023.09.20.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 01:09:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, arnd@arndb.de,
        deller@gmx.de
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] fbdev: Replace fb_pgprotect() with
 pgprot_framebuffer()
In-Reply-To: <20230912135050.17155-3-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
 <20230912135050.17155-3-tzimmermann@suse.de>
Date:   Wed, 20 Sep 2023 10:09:37 +0200
Message-ID: <87fs39l0zi.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Rename the fbdev mmap helper fb_pgprotect() to pgprot_framebuffer().
> The helper sets VMA page-access flags for framebuffers in device I/O
> memory.
>

I think this rename makes it more clear.

> Also clean up the helper's parameters and return value. Instead of
> the VMA instance, pass the individial parameters separately: existing
> page-access flags, the VMAs start and end addresses and the offset

But I fail to see the benefit of this part. Could you please add an
explanation about why this change is desirable ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

