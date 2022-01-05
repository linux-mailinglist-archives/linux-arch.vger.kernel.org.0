Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4062485BE0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 23:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbiAEWwd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 17:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbiAEWvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 17:51:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A7C034004
        for <linux-arch@vger.kernel.org>; Wed,  5 Jan 2022 14:51:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m21so2580982edc.0
        for <linux-arch@vger.kernel.org>; Wed, 05 Jan 2022 14:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ex7w8HcbpnD772/tbtITSyn/vheu68eRRqBswHSSKrI=;
        b=fSyfYTkUPYz+3jTngF7GUBGzyvhqqZNom7Kf6iML9n/fbaxlTB8pins4rMAgiEaWZy
         fsbLdancp+snTegRa/ALD6Oo6aSLUdUiqNs2GKMX7UmkDIEaOnGkeKfv/uqkqqRDJ3OI
         MkZuGFG3vnIxcPGkqIBzptIj1+pTTb3precp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ex7w8HcbpnD772/tbtITSyn/vheu68eRRqBswHSSKrI=;
        b=XtJKyJAK1ajr4WJz89ep0zKDDTnDzvnPt3GL2WPUpm8aibcZ09KH8NUiNlcIVBvWU/
         0fwxX/6TZJFp9ASy5t6W8SdqBB7NJpcVdmGpvWzsGUMwdxAx6Ej1tzXWyrtIpGTU6p+1
         FvXWoGxcUxMCARzLhKUGyYkeB8M8m1dUV2ZeJbFjAntRw2Gf+xqUcM1VpjVXb4FbQSQx
         P9QiPm3kBoYddEuUekVkX47cjbtGJ696hRinNTZeE81KP4mcFtFFmZbav6T2pJKDVpNE
         76zsdlrA8mLJLOiOK+jIBpG3X8oG1izGwk6l8fh7FkhxGnHnDzkwlxo14kioUOL5N+zG
         livA==
X-Gm-Message-State: AOAM532zdhA9e31tBMzNnf3cbbDpqLA9My95zpeIcHItgdn6rJPYRY8n
        cavbIRMvXCXZ53Kaz+t3sgukG9hmfYoQwWttFjM=
X-Google-Smtp-Source: ABdhPJyFqwnVeGU1evapeWGtlwasGyu55oZ4KD7eJeKrwgssBrySnmWNjdjrF1z9h/ct5HWdYOU/TA==
X-Received: by 2002:a05:6402:2809:: with SMTP id h9mr53914777ede.139.1641423082814;
        Wed, 05 Jan 2022 14:51:22 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id gb10sm54493ejc.49.2022.01.05.14.51.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:51:22 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id w20so1144797wra.9
        for <linux-arch@vger.kernel.org>; Wed, 05 Jan 2022 14:51:21 -0800 (PST)
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr47342739wrz.281.1641423081626;
 Wed, 05 Jan 2022 14:51:21 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-2-ebiederm@xmission.com> <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk>
 <871r1l9ai5.fsf@email.froward.int.ebiederm.org> <YdYTV9gQEPxssuZe@zeniv-ca.linux.org.uk>
In-Reply-To: <YdYTV9gQEPxssuZe@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 14:51:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggCHypiukgs2_tm-00r2xaAkG8MQjuZtSNoG_umg7Rrg@mail.gmail.com>
Message-ID: <CAHk-=wggCHypiukgs2_tm-00r2xaAkG8MQjuZtSNoG_umg7Rrg@mail.gmail.com>
Subject: Re: [PATCH 02/10] exit: Add and use make_task_dead.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 5, 2022 at 1:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 05, 2022 at 02:46:10PM -0600, Eric W. Biederman wrote:
> >
> > Being in assembly it did not have anything after the name do_exit so it
> > hid from my regex "[^A-Za-z0-9_]do_exit[^A-Za-z0-9]".  Thank you for
> > finding that.
>
> Umm...  What's wrong with '\<do_exit\>'?

Christ people, you both make it so complicated.

If you want to search for 'do_exit', just do

        git grep -w do_exit

where that '-w' does exactly that "word boundary" thing.

I thought everybody knew about this, because it's such a common thing
to do - checking my shell history, more than a third of my "git grep"
uses use '-w', exactly because it's very convenient for identifier
lookup

But yes, in more complex cases where you have other parts to the
pattern (ie you're not looking *just* for a single word), by all means
use '\<' and/or '\>'.

                 Linus
