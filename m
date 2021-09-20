Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C87412AF1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Sep 2021 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhIUCEH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 22:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhIUB7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2021 21:59:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDBDC08EB1E
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 11:04:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z24so45074882lfu.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C96pDQyYyFg5qDGVLf3sLPlA5hQ7a8vVkj08bMsCj8M=;
        b=EGycjJn+wnDLv4w5lW3U5Wn7gsAcaf6LTG1FqdE09AUzqmx2sOt3hXMLK/y4zNH99+
         fl7CiEBkM9aBwsZrcqA4birLn9joAVXIKzRyWchC462H9YmTKBBw+fnnMc/T3VbhuGn3
         Xr99GVBCb/6unRKmeB3xNNMDiBYkcm1rJQ8Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C96pDQyYyFg5qDGVLf3sLPlA5hQ7a8vVkj08bMsCj8M=;
        b=ZJmFEwxzSjUwf3MdEGPk5hdPClMzF2Czx8bSiMs+HY2NsO0oDrlzHKSncJ/PVOxtEv
         Qq4aN49dbB+z+7Vh7YLBsfjNpQ4i7TKPBtIb0yYJ5zAzDmDfFPFY89smDxEP8iKzaqN+
         qtkk3W+gzUPBlg76PvWveXLrU6psFRWAPGM+2R8nVTptV/ZRqt5SG05VfVfvWEEpn4xL
         ntr3SwJJyV8fZucFdDV9UEAfLe7zEvGNFx/LdPjCd9EXaS0HiJ84HPv/pe19FRZ4Yyxq
         HOgpp+M/VaqRwXA/ARd38HmBOIjfM4bCarbyifUTebXOtqnDMJJSbwKSCx2fq7zfgohk
         PBFA==
X-Gm-Message-State: AOAM532yhIv3ouydSJoqlg4La4jJV4CPG7mre/QJ14DTE4cuN9ygt/Qm
        isRELsumeZ5avbFdM0j6a12vlp9hbbqmXVVZ
X-Google-Smtp-Source: ABdhPJzymeZxMiZ/iJ+U+bYWQG8h/BTp0+Ji8s41JLOJk/QX7NAtlOWmH6hB+0aJ727OEIF8Wo62Xw==
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr4782736lfa.403.1632161055361;
        Mon, 20 Sep 2021 11:04:15 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q7sm1853218ljg.137.2021.09.20.11.04.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:04:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u8so19749830lff.9
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 11:04:14 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr4886099ljh.68.1632161051649;
 Mon, 20 Sep 2021 11:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
 <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
In-Reply-To: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 11:03:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9Th7A8eGiWK4gY8fGG41k6J3JQhip=4NCa9xUR7kMVQ@mail.gmail.com>
Message-ID: <CAHk-=wg9Th7A8eGiWK4gY8fGG41k6J3JQhip=4NCa9xUR7kMVQ@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 20, 2021 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But let me build a few more sparc configs (and this time do it
> properly for both 32-bit and 64-bit) before I actually commit it and
> push it out.

Actually, I think I _had_ tested sparc64 properly before, it's just
that I had only done the bigger configurations that had CONFIG_PCI
enabled and that didn't show the failure due to that.

But I have now done the allnoconfig and tinyconfig builds that showed
the problem, and verified that the trivial "depend on CONFIG_PCI"
fixes things for me.

Looks like the only remaining problem in your build configuration list
that isn't queued up somewhere is that odd nouveau use of pwrsrc and
the errno range thing. I'll apply it directly.

I'm sure that other configs will have a lot of other cases, but it is
good to see at least your set shrinking.

            Linus
