Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0425D1471B7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 20:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWT05 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 14:26:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35617 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWT05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 14:26:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so4975260lja.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2UUTxlhM8OOhUZ8uLYw5RDcPKulATuAhzOZCNZ3iAI=;
        b=DQmTS2sD5ZGak4DtLFZbvjA9rCQRhsUY5gHkLATq3NhUv208eViDb4ocXG8du312X/
         6tjxRwwVkl8pT5oSnn5dpbOWT4rJWBlKKov/ZNgF/8nl3MmlsztnaoW/MIYj8DmxCYoL
         1q/DKqnQSmGG1bprtb9ku108u7iQMpkCV0/yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2UUTxlhM8OOhUZ8uLYw5RDcPKulATuAhzOZCNZ3iAI=;
        b=BUmUOXWYrp//RfOh9grIxdV7eWVgeWmYO9gfjTHdBBJnUWp5eZ2xpwGXlho3VPl6YY
         5caHrnqgaiwtAGz+94G4xC1PW2HdXsEZMe5J2DUB4Tgwit/taPMv0QPj7/7zkqBr6hSA
         ny20OtrsJFNSUgYPlNJNWPW/YUvtGrttvCCzNfS2rzh1G/+yZrpeHUNlyryLOINvcaRG
         M97ODQ6eIJz2Jrz01hutuCMDI3RLD/MSnBmJOAcOBELjtw6KMJlAlGqBIz22UFKWvqQj
         MvU+Pg9pwaYUJAUQ5ujY6jao3Xd3K06YeP7wfyLik6zBj7DyJvDJlNjm0ehLBrqAOdIF
         rW8w==
X-Gm-Message-State: APjAAAWMoYa0lCmL1NxAZC+F7VymruGaofMtIZ8SpjppioD7x5IAE195
        khoBeXJFvIMWQU99kIT3SnVUt22bGII=
X-Google-Smtp-Source: APXvYqwdic0DyYlb3RHGM5wCtwIP3jfSg4xM/9T+j3f0g9456Xje6leJGT3W9dRjc3N7dVDZwheYEg==
X-Received: by 2002:a2e:7816:: with SMTP id t22mr80061ljc.161.1579807615293;
        Thu, 23 Jan 2020 11:26:55 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 21sm1797334ljv.19.2020.01.23.11.26.54
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:26:55 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id j1so4975191lja.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 11:26:54 -0800 (PST)
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr71515ljq.241.1579807614206;
 Thu, 23 Jan 2020 11:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 11:26:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
Message-ID: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Lovely. Thanks. Patches obviously all look fine.

On Thu, Jan 23, 2020 at 11:23 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> I'd _rather_ this go in via the x86 tree, but I'm not picky.  I could also
> send a pull request directly to Linus.

I have no strong feelings either way. I'll happily pull this tree for
the 5.6 merge window directly from you, or get it as part of one of
the x86 -tip pull requests.

Up to you and the -tip maintainers, really. Thomas/Ingo/Borislav?

                 Linus
