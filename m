Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EC4863B6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 12:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiAFL0h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 06:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbiAFL0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 06:26:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C6C061245;
        Thu,  6 Jan 2022 03:26:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id k15so8035993edk.13;
        Thu, 06 Jan 2022 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDcof6XJHSfM7835Lm7GTdME3n6+KXCAcTtGdmowBcU=;
        b=cgSLxRsy2oWZIoT6/YgYG+OE/gRmAjQcTTx7BQLh2oFccl5wPTqN7oQeC4l888nXUh
         Uhd6KdxA4zJVSGE4wrHsOZsy3GDjF+z9xZBqVYFSxN7o0v9KHwSA0J9JXuEAzaPfU44I
         L89Zv8IysBosAnrTeh7zh6PGIXyyyikB/OaU88M/0zBOBtlfFJRA5CueL5FBxVsw50zO
         kV/0wn7/CW8PvaKgLwAaItwI32FdNfT4tzSbbTa3eUJlxHkzFBfgEl1BCPTvgQFZaXbj
         RfxpUVpKrtEBg3k3JaTrbBml82br1BD3enh6iAmcKJY6Z8za+HajP5ck1eT8a0cYgEWQ
         5+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IDcof6XJHSfM7835Lm7GTdME3n6+KXCAcTtGdmowBcU=;
        b=ooEeTN8B0Z9Z+ULDOz1qKCqpFi/HB07rg0/KoQzm4dKdUm45jgGNujTwhbqUBqk0CF
         0LgTD5sdkxnu/ppT8nhDxOJHkpUSVvwEFJzLZUoD8TzwmAtte/coB1mH7cXg9bhr6R6I
         hNO7IAf5DFFz6cOuwBLBnyCo1P+kc/bGvQOhQ4IzWaHQZ/GkGnEGzOT9ijEsMrWI8BPI
         ghGBNBrlB6Gf63BI7QP0E0H1tiStbPa1+3h1mNSl29JHmE6t9yIiXVv9+FxL37Y7NcGM
         VoXMpgw7inOjroEfmg61wSfpD96hp7leRYTge1UHFpiNPLbRxUMyAGFBmSraFeWdRKvm
         vhNw==
X-Gm-Message-State: AOAM533zW7Uej/6DwElrEvxnW2EKnEb5vN8G3DpZ4rXb7rZ7B3bZKicS
        +XPVgXAgA0b93d2M1Qlq0eU=
X-Google-Smtp-Source: ABdhPJy9G3yw1nZgcGXCN1ARgx6fTEVgN/anJoqmFftdPtstEZeU1AV1MIvGWTuZmdwKmXj5N6c8CA==
X-Received: by 2002:a05:6402:1d4e:: with SMTP id dz14mr52680113edb.286.1641468394335;
        Thu, 06 Jan 2022 03:26:34 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id k25sm430401ejk.179.2022.01.06.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:26:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 6 Jan 2022 12:26:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] headers/uninline: Uninline single-use function:
 kobject_has_children()
Message-ID: <YdbR5cfCj20dlh0Z@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
 <YdRM7I9E2WGU4GRg@kroah.com>
 <YdRRl+jeAm/xfU8D@gmail.com>
 <YdRjRWHgvnqVe8UZ@kroah.com>
 <YdRkZqGuKCZcRbov@kroah.com>
 <YdTiF5dVeizYtIDS@gmail.com>
 <YdW33ITu4Hz3+kid@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdW33ITu4Hz3+kid@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Note that these latter two patches just simplified the task of my 
> > (simplistic) tooling, which is basically a shell script that inserts 
> > header dependencies to the head of .c and .h files, right in front of 
> > the first #include line it encounters.
> > 
> > These two patches do have some marginal clean-up value too, so I'm not 
> > opposed to merging them - just wanted to declare their true role. :-)
> 
> They all are sane cleanups, so I've taken them in my tree now.  Make your 
> patchset a bit smaller against 5.17-rc1 when that comes around :)

Thank you! :-)

	Ingo
