Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250522253B2
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jul 2020 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgGSTec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGSTea (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 15:34:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9DC0619D4
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:34:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so18014578ljm.1
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4iaAa1pJ3/vUXL+G0FL5XOVaOaVeIOdKQBxEAvPWUk=;
        b=hUj5SJIJp5WpT8tiJdx2CMecsKcJEqVlqdlhW6MORlAWnybeCPezD07typEeY2pzH4
         /ZktAwoD/GooFQ3xUbb7QJ97bNKTNjYZ7xG6wQxdrZPzrm5qDk9TlDrmtLv7I80qPdDB
         t+i7Jg3uGh63h0eUENt4UYDEoycbXbz0ouzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4iaAa1pJ3/vUXL+G0FL5XOVaOaVeIOdKQBxEAvPWUk=;
        b=O2YbXYu8y48HUVNcImtHc1hwi6dgI6p7AN7trCrbbSDMiauHHf+74Jn/51Ahu0FhqS
         SSwcfvlXZqDMwlh/Pstrx+kGg64LejyYUUtuI9f+s2UoRqZLWzaHWOEK9XnBLGSeqA/y
         P/Wdj1lyG33eg37FUh1z/fjOLLu8hYq1kEFISVYBxqkcf5UoOvwTqP2XeuN/Ipd7NMgc
         kAdIyNeinKMArPRMlOsAbGt8zyF8aFB1663b+01gsjmtWsWyQeEHL7VAldrS8vHEi3JM
         kSE3lqasIY1e+4ofACBNN9WBh32i0oiGmPLHI5+B7BKKAnViBp6HGnRXZbxhCg6GYbvv
         St0A==
X-Gm-Message-State: AOAM5330n2/xBeQArux73SLXY309fs5NFw79zmWaJQXwzqNEHK23couU
        tDapqHYRXyFdg0VdugNMBOlIx4Xsg/I=
X-Google-Smtp-Source: ABdhPJynDb3B1zYSJvE714i+0um96A+B6myzgYcxvysKJG/smiFIFrcHWKrZQbNq9F97XmJGUAe4BQ==
X-Received: by 2002:a2e:8210:: with SMTP id w16mr8644137ljg.419.1595187268086;
        Sun, 19 Jul 2020 12:34:28 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j17sm1065754lfr.32.2020.07.19.12.34.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 12:34:27 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q4so18044049lji.2
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:34:27 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr8453344ljj.314.1595187266940;
 Sun, 19 Jul 2020 12:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200719031733.GI2786714@ZenIV.linux.org.uk> <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jul 2020 12:34:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
Message-ID: <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
Subject: Re: [RFC] raw_copy_from_user() semantics
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think we should try to get rid of the exact semantics.

Side note: I think one of the historical reasons for the exact
semantics was that we used to do things like the mount option copying
with a "copy_from_user()" iirc.

And that could take a fault at the end of the stack etc, because
"copy_mount_options()" is nasty and doesn't get a size, and just
copies "up to 4kB" of data.

It's a mistake in the interface, but it is what it is. But we've
always handled the inexact count there anyway by originally doing byte
accesses, and at some point you optimized it to just look at where
page boundaries might be..

I think that was the only truly _valid_ case of "we actually copy data
from user space, and we might need to handle a partial case", and
exactly because of that, it had already long avoided the whole "assume
copy_from_user gives us byte-accurate data before the fault".

              Linus
