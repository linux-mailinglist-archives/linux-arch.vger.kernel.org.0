Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3F27114B
	for <lists+linux-arch@lfdr.de>; Sun, 20 Sep 2020 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgISWxp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 18:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgISWxo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 18:53:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F1C0613D6
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 15:53:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so5159104pjh.5
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:subject:mime-version:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=OiG9AhNV/aYytBLvfrNKs+OEikcE/xFc3qwTD8LXQak=;
        b=JqRJRr8pAqbUpB6Z8cyMrJ9xHdq76J9quA0nLvKh3ZCmreRApMtVEKJrUh1+iYF6JM
         j7I4CbitDi/hbJxI3A0yUx65zzxj+9OuhhpvKck/wUnRBF7EuGclsOL0nDYDl8Jf5W94
         LKjbYdiN8NQkyPDzWNzRWKhhUpI5BiYKfIYVYjgQr06v6tspjh4Kfljk2gKaOIdeu1AS
         kmjSb7FfVExI6FATCE4tuWlmlbDYHr+Rf4lm9eioaoVVJRTCo1VHPqqwu78Yo7heUEN2
         jwKtRhH+4KJ2y45vqwGsl3R+5jHCVoZnWHE5+MXw1OCY8mxZ6/yyA8kWQtdSX7UdFXP9
         eHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:subject:mime-version
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=OiG9AhNV/aYytBLvfrNKs+OEikcE/xFc3qwTD8LXQak=;
        b=imgokVQMJA0eEjAEs7b2Eso6INurbHXO3gn3m9KdvXdPj+dHoo0UmlMm8j9fMMXdYh
         SsBWeAug/26+iRNcgp+steqNtnr5QQ2EBMF31boRuoAPrDyANe1cIKYdVzVoGfxea9Bs
         h6yIwLM7p1+Nt9L8/EcLA0A14BJ50AUmO/I+Z74MZte4xmhFOT1er1myyYxuGYUQ9aIr
         MxPkrBxoTd0m49ljFqkj7OQgvULFLE9r3Lin8AOKFdWGDeVfsC9XHldM/XSQ5jfyYsYE
         Rb9i2cHpW73WZzX0tzjY0o9qmTmuerMNVz67lZ+vY4Nu9VSi8cA2xVx5CynO89aKMW7+
         QuaA==
X-Gm-Message-State: AOAM5317O1AVnkq7PMLpQi11FNHosdVFq3bBgtxH6j2CKzh1ozNmfjM1
        172NgoxZ2IVUvbHu57F+FA8zBA==
X-Google-Smtp-Source: ABdhPJz6oUPJzoZ809X6It3WeC+2ZvOV1G+Wm8aqeVVuTi4tgGB6DMhswwyVupUYmjfKPmBsWvoOLQ==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr17372330pjb.210.1600556023735;
        Sat, 19 Sep 2020 15:53:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1010:b017:20a:100a:bebe:fad7:f7f9])
        by smtp.gmail.com with ESMTPSA id n9sm7688488pfu.163.2020.09.19.15.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 15:53:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: E3EC9A91-0DBF-46AE-A57B-AC669BA7C6D0
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Sat, 19 Sep 2020 15:53:40 -0700
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Sep 19, 2020, at 3:41 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> =EF=BB=BFOn Sat, Sep 19, 2020 at 03:23:54PM -0700, Andy Lutomirski wrote:
>>=20
>>>> On Sep 19, 2020, at 3:09 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>=20
>>> =EF=BB=BFOn Fri, Sep 18, 2020 at 05:16:15PM +0200, Christoph Hellwig wro=
te:
>>>>> On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
>>>>> Said that, why not provide a variant that would take an explicit
>>>>> "is it compat" argument and use it there?  And have the normal
>>>>> one pass in_compat_syscall() to that...
>>>>=20
>>>> That would help to not introduce a regression with this series yes.
>>>> But it wouldn't fix existing bugs when io_uring is used to access
>>>> read or write methods that use in_compat_syscall().  One example that
>>>> I recently ran into is drivers/scsi/sg.c.
>>>=20
>>> So screw such read/write methods - don't use them with io_uring.
>>> That, BTW, is one of the reasons I'm sceptical about burying the
>>> decisions deep into the callchain - we don't _want_ different
>>> data layouts on read/write depending upon the 32bit vs. 64bit
>>> caller, let alone the pointer-chasing garbage that is /dev/sg.
>>=20
>> Well, we could remove in_compat_syscall(), etc and instead have an implic=
it parameter in DEFINE_SYSCALL.  Then everything would have to be explicit. =
 This would probably be a win, although it could be quite a bit of work.
>=20
> It would not be a win - most of the syscalls don't give a damn
> about 32bit vs. 64bit...

Any reasonable implementation would optimize it out for syscalls that don=E2=
=80=99t care.  Or it could be explicit:

DEFINE_MULTIARCH_SYSCALL(...)=
