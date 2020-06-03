Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1981ED384
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jun 2020 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCPhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCPhS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 11:37:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EBEC08C5C0;
        Wed,  3 Jun 2020 08:37:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s23so519187pfh.7;
        Wed, 03 Jun 2020 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oja/QTDc5nY9hQwAXuclHQY4F3oBF5r1pW9cwZnZ+X4=;
        b=ZXJWnFWPnh5MqF8yFf9qnpzT4yi3So+4B5egS4fWYyl7m0FU3Cy9Lo5dGUxaVWFR9v
         G4Dq9AsLtfQyAlFI9BMOe7me5k7EpagXjuBaNsawqTKB+l7QzNmDf00aS6AiDCjjKcfB
         nbQTNjYbJPN7k9AOireY+pjcju2bjPyCAgxZgEFUW4aESyV72ohgzCPU1l90IF4BtfaS
         9U8DhdPqpZlT+hjxLqCvtYqZYaT1SDQqz2PP6U2tWU8Rd3BAxTfXYTnaW7o0M/yyEu7m
         fywyS2zWf3JIuMt5Ja8LNt4v2MUhUvkl5NmubDISzgpGjFgvKBS0Vn6SxbX8v2qrDQhY
         RHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oja/QTDc5nY9hQwAXuclHQY4F3oBF5r1pW9cwZnZ+X4=;
        b=J50liQ+9nqUzpf1LXDutkUbXfPY9+wf/FXFOfDNtzlTuOF29toMlVVAlngIIrwgpqw
         gd2dpoEM2aKBqTp4TjW6/8osDg3hucyQSvzsDGtv1fkDUWMyB3DvPsCJuFAGK/4LKOae
         p6g5Z3eLOqJA7x5u1OuCVcFIGE5uZUSn5WqaZ4OMxPtdSoam7Ob35FzCGFwnDPXdRNmx
         Ys8bF5coyCOVi9j+xUSa1YrIIe8cB+KYH1IByXDPgHtyKpJCQYOm1yYdYPCdWmm1ust8
         o6hNqC1DbNYnpF3TyI8aYQVIxfYxM9gFGG6mcdWvZIwMwfc3ZUO+j9ghlPzHSzJ/7RqA
         n51g==
X-Gm-Message-State: AOAM530WK6Kb1JJr0vH7xdcT3Kqh9g6LtMoKFS7SckviUtL4dXXNZbrB
        NJHJNOagdyFN5dv3+szGBJN06lkj
X-Google-Smtp-Source: ABdhPJzzLqeER6FoyTzHOsNBsA9hvP0AxeupOTcszhQE2UphbBm8z/GfP4QO+jMqiwkn/QKGh7EiRg==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr340959pjb.208.1591198636589;
        Wed, 03 Jun 2020 08:37:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u1sm1878219pgf.28.2020.06.03.08.37.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 08:37:15 -0700 (PDT)
Date:   Wed, 3 Jun 2020 08:37:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 05/14] ia64: csum_partial_copy_nocheck(): don't
 abuse csum_partial_copy_from_user()
Message-ID: <20200603153714.GA33147@roeck-us.net>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
 <20200327233117.1031393-5-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327233117.1031393-5-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 27, 2020 at 11:31:08PM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Just inline the call and use memcpy() instead of __copy_from_user() and
> note that the tail is precisely ia64 csum_partial().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This patch results in:

arch/ia64/lib/csum_partial_copy.c: In function 'csum_partial_copy_nocheck':
arch/ia64/lib/csum_partial_copy.c:110:9: error: implicit declaration of function 'csum_partial'

for ia64:{defconfig, allnoconfig, tinyconfig}.

Guenter

---
# bad: [d6f9469a03d832dcd17041ed67774ffb5f3e73b3] Merge tag 'erofs-for-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
# good: [b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69] Merge tag 'docs-5.8' of git://git.lwn.net/linux
git bisect start 'HEAD' 'b23c4771ff62'
# good: [6cf991611bc72c077f0cc64e23987341ad7ef41e] Merge tag 'drm-intel-next-2020-05-15' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good 6cf991611bc72c077f0cc64e23987341ad7ef41e
# bad: [faa392181a0bd42c5478175cef601adeecdc91b6] Merge tag 'drm-next-2020-06-02' of git://anongit.freedesktop.org/drm/drm
git bisect bad faa392181a0bd42c5478175cef601adeecdc91b6
# bad: [c5d6c13843880ad0112f0513f3eb041b258be66e] Merge tag 'mmc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad c5d6c13843880ad0112f0513f3eb041b258be66e
# bad: [94709049fb8442fb2f7b91fbec3c2897a75e18df] Merge branch 'akpm' (patches from Andrew)
git bisect bad 94709049fb8442fb2f7b91fbec3c2897a75e18df
# good: [a29adb6209cead1f6c34a8d72481fb183bfc2d68] mm: rename vmap_page_range to map_kernel_range
git bisect good a29adb6209cead1f6c34a8d72481fb183bfc2d68
# bad: [56446efab9ce4961fe0fe6bbc5bc66374b08b9f3] Merge branch 'uaccess.__copy_from_user' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad 56446efab9ce4961fe0fe6bbc5bc66374b08b9f3
# good: [87c233b8158a20a9c9ab1da96cb5cb1734d9006e] vmci_host: get rid of pointless access_ok()
git bisect good 87c233b8158a20a9c9ab1da96cb5cb1734d9006e
# bad: [001c1a655f0a4e4ebe5d9beb47466dc5c6ab4871] default csum_and_copy_to_user(): don't bother with access_ok()
git bisect bad 001c1a655f0a4e4ebe5d9beb47466dc5c6ab4871
# bad: [808b49da54e640cba5c5c92dee658018a529226b] alpha: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
git bisect bad 808b49da54e640cba5c5c92dee658018a529226b
# good: [0a5ea224b2fdf9dca9291ef7b5a12fd846a5dc34] x86: switch both 32bit and 64bit to providing csum_and_copy_from_user()
git bisect good 0a5ea224b2fdf9dca9291ef7b5a12fd846a5dc34
# bad: [cc03f19cfd45f44a75f0445c5be0073bbd3dda1c] ia64: csum_partial_copy_nocheck(): don't abuse csum_partial_copy_from_user()
git bisect bad cc03f19cfd45f44a75f0445c5be0073bbd3dda1c
# good: [c281a6c1ac6b0867e4341ea801030fa9a62157f9] x86: switch 32bit csum_and_copy_to_user() to user_access_{begin,end}()
git bisect good c281a6c1ac6b0867e4341ea801030fa9a62157f9
# first bad commit: [cc03f19cfd45f44a75f0445c5be0073bbd3dda1c] ia64: csum_partial_copy_nocheck(): don't abuse csum_partial_copy_from_user()
