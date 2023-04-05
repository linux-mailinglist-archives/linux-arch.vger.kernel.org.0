Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECF6D830B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDEQHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDEQHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 12:07:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B094EDB
        for <linux-arch@vger.kernel.org>; Wed,  5 Apr 2023 09:07:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5002f12ccfeso76126a12.0
        for <linux-arch@vger.kernel.org>; Wed, 05 Apr 2023 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680710851; x=1683302851;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir3s/Lf5lvCAlrm1TfcesrDtB2jAmtZCISN/6dp3hBc=;
        b=VNUObGKko6sqyyipxJHZOjjD7Vgl2nINPanPLg9CF5dNFM42M+zPkinw5lJovFp5IT
         KgryiwfHZwGoUCHvFhE9cgxsLTI65w6qpIN9bd0/wPOfFcL5qWWLKMUORCChrg/EDytj
         /mEZ5jrCc5FzC1si2MslaSmste3VoXKbRjv7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710851; x=1683302851;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir3s/Lf5lvCAlrm1TfcesrDtB2jAmtZCISN/6dp3hBc=;
        b=yumicNzI+yC50U+8FyrJu0CJQqPZpweKlyMCsc+x6xR+bMpxDvRVmAMD8VF7DC6tvQ
         RSSKYazjNfDjpKnr7m9zHiQBMe4FyRNDrp9JSv9+qQ3iCRE6C+8eC364h3RGvW6NoXuy
         UqVKKhBRP8d+/X0vXso/7BPnTXLEPvO4o3kiNu5Ufv5NCunwQzsgfjjvGBDSMhXG0gjJ
         LgwrR8OdaRTQZ/DZ1GzmcHX9TSbiQCWNkPJWD6pPLk2MssFYJK+caWbkt6lPLFxF48qf
         E23FzdS5gqovuws4n10/YYIugBnaXKNxQ91uOvOM2zYP77kuNITU6+3NarEItGualKm6
         /DeQ==
X-Gm-Message-State: AAQBX9ffbidJgUwam2UaA1UEAHhxkfp55ek4eMI4vmkZ4Csrpf75rjY5
        KL9pQlUR4C/UHpgO/MxB0d7HKQ==
X-Google-Smtp-Source: AKy350aQMCCIGd+ttlIn6lmvnbNQhhwBJ1Oi0jxEBwn9z6WIX2aUYNMX4MoVCA82q+F4FspzQF+uZA==
X-Received: by 2002:a17:906:10c9:b0:931:4285:ea16 with SMTP id v9-20020a17090610c900b009314285ea16mr2360239ejv.7.1680710851411;
        Wed, 05 Apr 2023 09:07:31 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id a23-20020a170906369700b0092a59ee224csm7492153ejc.185.2023.04.05.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:07:31 -0700 (PDT)
Date:   Wed, 5 Apr 2023 18:07:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/18] fbdev: Prepare generic architecture helpers
Message-ID: <ZC2cwIJJlyDWge+B@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
References: <20230405150554.30540-1-tzimmermann@suse.de>
 <20230405150554.30540-2-tzimmermann@suse.de>
 <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 05:53:03PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 5, 2023, at 17:05, Thomas Zimmermann wrote:
> > Generic implementations of fb_pgprotect() and fb_is_primary_device()
> > have been in the source code for a long time. Prepare the header file
> > to make use of them.
> >
> > Improve the code by using an inline function for fb_pgprotect() and
> > by removing include statements.
> >
> > Symbols are protected by preprocessor guards. Architectures that
> > provide a symbol need to define a preprocessor token of the same
> > name and value. Otherwise the header file will provide a generic
> > implementation. This pattern has been taken from <asm/io.h>.
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Moving this into generic code is good, but I'm not sure
> about the default for fb_pgprotect():
> 
> > +
> > +#ifndef fb_pgprotect
> > +#define fb_pgprotect fb_pgprotect
> > +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> > +				unsigned long off)
> > +{ }
> > +#endif
> 
> I think most architectures will want the version we have on
> arc, arm, arm64, loongarch, and sh already:
> 
> static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>                                 unsigned long off)
> {
>        vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> }
> 
> so I'd suggest making that version the default, and treating the
> empty ones (m68knommu, sparc32) as architecture specific
> workarounds.

Yeah I was about to type the same suggestion :-)
-Daniel

 
> I see that sparc64 and parisc use pgprot_uncached here, but as
> they don't define a custom pgprot_writecombine, this ends up being
> the same, and they can use the above definition as well.
> 
> mips defines pgprot_writecombine but uses pgprot_noncached
> in fb_pgprotect(), which is probably a mistake and should have
> been updated as part of commit 4b050ba7a66c ("MIPS: pgtable.h:
> Implement the pgprot_writecombine function for MIPS").
> 
>     Arnd

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
