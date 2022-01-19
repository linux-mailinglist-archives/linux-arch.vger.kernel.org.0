Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF374942B1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jan 2022 23:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357467AbiASWA3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jan 2022 17:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiASWA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2022 17:00:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F02C06161C
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 14:00:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a5so3529813pfo.5
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JI5jEcI1hiEGc8WLPgbqQTxkl08Ju0kSWlXY2eIoY9Q=;
        b=Qxk8ZlOzgx4vMG2yojzX5wqvtn5rpGheXm11Z2NyGGBIUXeWLr4XOg3b0q3SyZigtH
         iGaQnWl3zb1OvgUv/kyJhvoC8mXZPAhUz50q7uhfasP7KXx2JeaPhKPNgtg4s8H9BDUo
         vvaHlGGVz9UU7HVblsspusc51ErXeXhgqq8Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JI5jEcI1hiEGc8WLPgbqQTxkl08Ju0kSWlXY2eIoY9Q=;
        b=AcO5UQUheBmr1Uol1E6qAEQZWAOAfTPnvcWvkKVCaRxovzbFKAwZOjYdT77hj8/pM5
         SnimJ/N4jurmI8GUMycKTy9H8d0VGYMqh6K4jvW5n2ij2x3PrSAAhU9HtDf8Wu6lM46d
         +r4vG2Hzh67IdGObMxfgOb23zpvz03NjBIJ0whqc/8oRaMmk6jQ6HiVBI/Q46LgVW116
         O7GL8UdeynwvhDJ/Rui9zoL2GqxNMpQKeFoB8/1aizSEiNlnVdpx6mK7TmiJ6ixD4YFD
         SV+bcSvnlKls/1v4JRDiaTlfDlIXXMSt/o57CPDqc03y24i1BCh2S1i6rNW9n2FoEpSY
         eusA==
X-Gm-Message-State: AOAM532UqPsQjVp32Web4noF5R/NdvuSd89SRTXBL6Ultlo29mRKyRsj
        y/655UTZpCpqYo0I1aaj8pb0MQ==
X-Google-Smtp-Source: ABdhPJwt4Nv5793SP6zTE20w2tmeoTfB5V156ftaoTtLpJsdxvELruQabzZX/RUlM9ATmwCRik8jUg==
X-Received: by 2002:aa7:918e:0:b0:4bb:793:b7a7 with SMTP id x14-20020aa7918e000000b004bb0793b7a7mr32876692pfa.71.1642629627636;
        Wed, 19 Jan 2022 14:00:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12sm602597pfc.107.2022.01.19.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 14:00:26 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:00:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 11/12] lkdtm: Fix execute_[user]_location()
Message-ID: <202201191359.5E67E74A@keescook>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <d4688c2af08dda706d3b6786ae5ec5a74e6171f1.1634457599.git.christophe.leroy@csgroup.eu>
 <e7793192-6879-490d-1f37-3d6d6908a121@csgroup.eu>
 <c635dff6-2bca-3486-014f-12ae00bd1777@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c635dff6-2bca-3486-014f-12ae00bd1777@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 19, 2022 at 08:28:54PM +0100, Christophe Leroy wrote:
> Hi Kees,
> 
> 
> Le 17/12/2021 à 12:49, Christophe Leroy a écrit :
> > Hi Kees,
> > 
> > Le 17/10/2021 à 14:38, Christophe Leroy a écrit :
> > > execute_location() and execute_user_location() intent
> > > to copy do_nothing() text and execute it at a new location.
> > > However, at the time being it doesn't copy do_nothing() function
> > > but do_nothing() function descriptor which still points to the
> > > original text. So at the end it still executes do_nothing() at
> > > its original location allthough using a copied function descriptor.
> > > 
> > > So, fix that by really copying do_nothing() text and build a new
> > > function descriptor by copying do_nothing() function descriptor and
> > > updating the target address with the new location.
> > > 
> > > Also fix the displayed addresses by dereferencing do_nothing()
> > > function descriptor.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > Do you have any comment to this patch and to patch 12 ?
> > 
> > If not, is it ok to get your acked-by ?
> 
> Any feedback please, even if it's to say no feedback ?

Hi! Thanks for the ping; I haven't had time yet to look at this, but
with -rc1 coming, I should be able to task-switch back to LKDTM for the
dev cycle and I can give some feedback.

-Kees

> 
> Many thanks,
> Christophe
> 
> > 
> > Thanks
> > Christophe
> > 
> > > ---
> > >   drivers/misc/lkdtm/perms.c | 37 ++++++++++++++++++++++++++++---------
> > >   1 file changed, 28 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> > > index 035fcca441f0..1cf24c4a79e9 100644
> > > --- a/drivers/misc/lkdtm/perms.c
> > > +++ b/drivers/misc/lkdtm/perms.c
> > > @@ -44,19 +44,34 @@ static noinline void do_overwritten(void)
> > >       return;
> > >   }
> > > +static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
> > > +{
> > > +    if (!have_function_descriptors())
> > > +        return dst;
> > > +
> > > +    memcpy(fdesc, do_nothing, sizeof(*fdesc));
> > > +    fdesc->addr = (unsigned long)dst;
> > > +    barrier();
> > > +
> > > +    return fdesc;
> > > +}
> > > +
> > >   static noinline void execute_location(void *dst, bool write)
> > >   {
> > > -    void (*func)(void) = dst;
> > > +    void (*func)(void);
> > > +    func_desc_t fdesc;
> > > +    void *do_nothing_text = dereference_function_descriptor(do_nothing);
> > > -    pr_info("attempting ok execution at %px\n", do_nothing);
> > > +    pr_info("attempting ok execution at %px\n", do_nothing_text);
> > >       do_nothing();
> > >       if (write == CODE_WRITE) {
> > > -        memcpy(dst, do_nothing, EXEC_SIZE);
> > > +        memcpy(dst, do_nothing_text, EXEC_SIZE);
> > >           flush_icache_range((unsigned long)dst,
> > >                      (unsigned long)dst + EXEC_SIZE);
> > >       }
> > > -    pr_info("attempting bad execution at %px\n", func);
> > > +    pr_info("attempting bad execution at %px\n", dst);
> > > +    func = setup_function_descriptor(&fdesc, dst);
> > >       func();
> > >       pr_err("FAIL: func returned\n");
> > >   }
> > > @@ -66,16 +81,19 @@ static void execute_user_location(void *dst)
> > >       int copied;
> > >       /* Intentionally crossing kernel/user memory boundary. */
> > > -    void (*func)(void) = dst;
> > > +    void (*func)(void);
> > > +    func_desc_t fdesc;
> > > +    void *do_nothing_text = dereference_function_descriptor(do_nothing);
> > > -    pr_info("attempting ok execution at %px\n", do_nothing);
> > > +    pr_info("attempting ok execution at %px\n", do_nothing_text);
> > >       do_nothing();
> > > -    copied = access_process_vm(current, (unsigned long)dst, do_nothing,
> > > +    copied = access_process_vm(current, (unsigned long)dst,
> > > do_nothing_text,
> > >                      EXEC_SIZE, FOLL_WRITE);
> > >       if (copied < EXEC_SIZE)
> > >           return;
> > > -    pr_info("attempting bad execution at %px\n", func);
> > > +    pr_info("attempting bad execution at %px\n", dst);
> > > +    func = setup_function_descriptor(&fdesc, dst);
> > >       func();
> > >       pr_err("FAIL: func returned\n");
> > >   }
> > > @@ -153,7 +171,8 @@ void lkdtm_EXEC_VMALLOC(void)
> > >   void lkdtm_EXEC_RODATA(void)
> > >   {
> > > -    execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
> > > +    execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing),
> > > 
> > > +             CODE_AS_IS);
> > >   }
> > >   void lkdtm_EXEC_USERSPACE(void)
> > > 

-- 
Kees Cook
