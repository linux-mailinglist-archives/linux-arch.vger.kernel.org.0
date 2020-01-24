Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0913147533
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 01:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAXABf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 19:01:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgAXABf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 19:01:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id t23so27115lfk.6
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhm2D+li3tmVDnNelGAqg3FFAOKpjt8nabPCXHsBG0s=;
        b=eKsTsz3Wf3wiI8V2rq1anbSVH1riJLeQn47OGE8BF0Q1CYE2V9ccR1xO7DlIcJ1pQy
         71wkXkKtS/oqShBMuWd3FnkQjd+IxNRrQR1+BU9RCFPCvDLs2DVCbN/VY4PESU/m18IJ
         xen30k5igK5m42e4s/djap8cawEzHd2B1YLu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhm2D+li3tmVDnNelGAqg3FFAOKpjt8nabPCXHsBG0s=;
        b=i5Ilcqi/GzltmbGNM+iMGIN1ZKrqxDmJlD3Wzczpx1HrnKNtr2lFsHy2HQqnQvC0sG
         tf9gSO5ur6vf6NS084O6mMu/rRMnZNvcGPsVPboR3Ru9vSRQkm1h8zgEq0ARfxU+YWMR
         Dsw58mMTujWk/Cll4E+4kvXIG6ZU4Sl1wehxXtP1si/uGonVkbFpaW/g4P7MtCNSy/ht
         cX6kS+/NW4gsvkvnpn5tI07+MOhdQgepkoq4QjrCUV4WZKJjlP0p8L9MUTZAWFvpT9CT
         B1mGfqvRyDCm+drRp+voNgSymhFG4Pim3pjTXa1fr/9iSRhQVnXCoNHGhwkYvi/VqDkd
         +TQQ==
X-Gm-Message-State: APjAAAUJiVZhxWtnhmo6Gebi/syPzW0+onnaed5iaH3oUv2Z+s8v55LS
        Agm/TTGshkH4pYxywzA1v3+0d855LsE=
X-Google-Smtp-Source: APXvYqxlkVhh4DZCZmY6RBQgONRQEwkDhlybk4wpq+xdS1MHPnjBMoHtnEndsTe5LzV/39VQazWKDA==
X-Received: by 2002:a19:c014:: with SMTP id q20mr146764lff.208.1579824092723;
        Thu, 23 Jan 2020 16:01:32 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m24sm2440560ljb.81.2020.01.23.16.01.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 16:01:31 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id r19so398018ljg.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 16:01:31 -0800 (PST)
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr556562lja.16.1579824091393;
 Thu, 23 Jan 2020 16:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20200123190456.8E05ADE6@viggo.jf.intel.com> <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
 <20200123202600.GG10328@zn.tnic> <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
In-Reply-To: <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 16:01:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibZoVAzGpO-OssKN8cidpCKrfdDcMaspM6JW-3fbcSmQ@mail.gmail.com>
Message-ID: <CAHk-=wibZoVAzGpO-OssKN8cidpCKrfdDcMaspM6JW-3fbcSmQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 1:23 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> I'm confident I can send patches to the x86 maintainers and not make
> them too angry.  Sending pull requests to Linus, not so much. :)

With a diffstat summary like

 24 files changed, 2 insertions(+), 1697 deletions(-)

there's not a lot I could complain about ;l)

> I'll just plan to send it to Linus directly.

I do note that while I've merged patch series from you before, I don't
seem to have done a git pull from you.

But since you already have a git tree, and the tree looks fine, it
really is just a git request-pull, and you basically already have the
cover-letter to add to the email.

In fact, you don't even have to use a signed tag since it's on
kernel.org - but it's always nice to see, and you can put the cover
letter explanation into the tag.

             Linus
