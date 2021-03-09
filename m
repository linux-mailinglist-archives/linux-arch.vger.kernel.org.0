Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EB332F63
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCITzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 14:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhCITzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 14:55:11 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57427C06174A
        for <linux-arch@vger.kernel.org>; Tue,  9 Mar 2021 11:55:11 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id m11so22346919lji.10
        for <linux-arch@vger.kernel.org>; Tue, 09 Mar 2021 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vt6mkj0jVSFTyY251Tb+CgzT35tgzBSQBV+Cmr871e4=;
        b=HuwD6tNld4iJU8Mjzfb5DkBasrVtWUDLvxCey2JTv3AkO14FHWHCfvCBwVVm9qmad7
         XVSyULhL/IA06Np4AEJ6M0SLOPBYwCPPl3mkeVZblnO5S5Nb7yneY7pAgZy/IOR41zgQ
         F/1JI+UzQGWnuob1RvDgYA7ZEYuIgahwstCvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vt6mkj0jVSFTyY251Tb+CgzT35tgzBSQBV+Cmr871e4=;
        b=AZ5zrd7oSiO7lGnx6oV5Ufah8EBLylojTKooE0j1qPZ7cDCHHD1yewhS3I+ndqplp6
         V1b8kDuORshqMSRAAsfe7gSdRREqjvX9owJb02vj78mLNz8IuMuOmTqOzHjxYoB3WId3
         5IjSRbMbvyukPAWMgIXbocXEC+x2FFZ+09BM9zbmenSTMvvTtobG3F4jBmei640wRnuY
         saSAXFPxjX1xSvtO+oNpz1kR0b1iTuHah6ZhKby8vpAmEOFc1cMBYSvvrY+KlQ5oAgC8
         Q1/MPi3llwP0qWf79QDKdEqDcUuVE7NfRm3fzr+gfXCuk5QErfMsDZDqd914nyH2uZKn
         /t+g==
X-Gm-Message-State: AOAM533l2Y+OFZvz0qeyxiIlT55LK3VVcTnPLO7lm2B//3ohFXvfDK5P
        zL0SP287iNp8tcylP6MUCL62Pei4PhZA8Q==
X-Google-Smtp-Source: ABdhPJyd5mmfHDXuaxDmekH3U/VGZrvVP+3wrmfbEZHnQPnYLp7u95yTODUAOfYGOpwBGoJglpyK0A==
X-Received: by 2002:a2e:6e17:: with SMTP id j23mr17680662ljc.209.1615319709238;
        Tue, 09 Mar 2021 11:55:09 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z81sm2088781lfc.149.2021.03.09.11.55.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:55:08 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id k9so29236217lfo.12
        for <linux-arch@vger.kernel.org>; Tue, 09 Mar 2021 11:55:07 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr18981829lfu.253.1615319707578;
 Tue, 09 Mar 2021 11:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20210309151737.345722-1-masahiroy@kernel.org> <20210309151737.345722-5-masahiroy@kernel.org>
In-Reply-To: <20210309151737.345722-5-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 11:54:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8qKZYoN-M5a5-=ps7Cf_obtd0P_-0h+nMQEWkVqGFzg@mail.gmail.com>
Message-ID: <CAHk-=wh8qKZYoN-M5a5-=ps7Cf_obtd0P_-0h+nMQEWkVqGFzg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kbuild: remove guarding from TRIM_UNUSED_KSYMS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 9, 2021 at 7:18 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Now that the build time cost of this option is unnoticeable level,
> revert the following two:

It might still be a good idea to make it depend on EXPERT. Otherwise
you'll have problems with external modules..

Also, can you actually specify that "unnoticeable level" with numbers?

             Linus
