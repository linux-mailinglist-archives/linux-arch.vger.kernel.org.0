Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3975270FD7
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgISRjh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISRjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 13:39:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C110C0613CE
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 10:39:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k133so671506pgc.7
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VX3X8B9i2JuVY8GKzUZczdeUGgzu+mz4I4B7H1L1Mi4=;
        b=yNPYVlEt8KLUpDj0nIzrfQfQyOdEE2/k8kLlUB7RQ5n6+/jDfT84IduqimvSwqUnN+
         O8cF1Vj9icMa6rtMohIfNPMBvBf+j5VOOL/nVKGeLwQaWHmre9d1e1eyeGjPlO0i185k
         19M+FaJ2tfK5IgYz44rWxcBDCTmpp0Z3ZkuYLoAJ7sEpVZWAkov/AWsGiTkdIM78GAWZ
         2SydI0qut+RoG6GfTRienTfRUllaANJil5Y4kTZKmgGH3olgwZI6GM0CUjDKWTHCvMx5
         O22OBQlNd7hvBXTdnCIrUc+v+PA4zcggLM3FBA+YKoFQ9LtbqGzxxsi8TrAMrtNnfamF
         lVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VX3X8B9i2JuVY8GKzUZczdeUGgzu+mz4I4B7H1L1Mi4=;
        b=eI8zVR2ks7M+UMzVzXHxUeK+19khAuysv8tpkAB5RmaSSejg3LwdkN0Xj9iETacQiX
         IRnNZoVwdFx7FI1eZ8CYl7bohpqyg8gn7yKck0yP1XA6634k8hUQ62IYRqAwfgKIgctu
         VhoRbNPuHi6wkzUzdvQLsb9od77jKV5ZD32hA/MMyOrcikX+20RRCehbASP0+RrZn2FF
         LKkklUOZYpIyWQvsGOFC1BNFS79ue0VjmZu3mcwe8ilDjMT3Uw8knw4i5McxVmf0CCGN
         RlKDbib4dfcTqylDOURnx7lpG+juTnedQVDsXoJwbFMLnfz40gRJWNZpLEe+MEI35Dt0
         GPtw==
X-Gm-Message-State: AOAM5305IaDV9Z66LGj5e8OerrwoM8ACSaXsaCFpQlZJssBmtXOGD7rV
        zqKmSlwlhcdVG0PjScSLIo0aqQ==
X-Google-Smtp-Source: ABdhPJzr4nh4gV3U14vwhAcEwgphaAXOoSwKdUFhR57nYwWZfIBDT/DgQ4ly48zPilrTYeeOHRF+VQ==
X-Received: by 2002:a63:725d:: with SMTP id c29mr8480027pgn.234.1600537175557;
        Sat, 19 Sep 2020 10:39:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:c200:1ef2:384f:efa4:98e3:a556])
        by smtp.gmail.com with ESMTPSA id o19sm7291347pfp.64.2020.09.19.10.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:39:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
Date:   Sat, 19 Sep 2020 10:39:32 -0700
Message-Id: <027BAF5D-1473-4A35-8A58-D80315D52073@amacapital.net>
References: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>, Brian Gerst <brgerst@gmail.com>
In-Reply-To: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
To:     hpa@zytor.com
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Sep 19, 2020, at 10:14 AM, hpa@zytor.com wrote:
>=20
> =EF=BB=BFOn September 19, 2020 9:23:22 AM PDT, Andy Lutomirski <luto@kerne=
l.org> wrote:
>>> On Fri, Sep 18, 2020 at 10:35 PM Christoph Hellwig <hch@infradead.org>
>>> wrote:
>>>=20
>>> On Fri, Sep 18, 2020 at 03:24:36PM +0200, Arnd Bergmann wrote:
>>>> sys_move_pages() is an optional syscall, and once we remove
>>>> the compat version of it in favor of the native one with an
>>>> in_compat_syscall() check, the x32 syscall table refers to
>>>> a __x32_sys_move_pages symbol that may not exist when the
>>>> syscall is disabled.
>>>>=20
>>>> Change the COND_SYSCALL() definition on x86 to also include
>>>> the redirection for x32.
>>>>=20
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>=20
>>> Adding the x86 maintainers and Brian Gerst.  Brian proposed another
>>> problem to the mess that most of the compat syscall handlers used by
>>> x32 here:
>>>=20
>>>   https://lkml.org/lkml/2020/6/16/664
>>>=20
>>> hpa didn't particularly like it, but with your and my pending series
>>> we'll soon use more native than compat syscalls for x32, so something
>>> will need to change..
>>=20
>> I'm fine with either solution.
>=20
> My main objection was naming. x64 is a widely used synonym for x86-64, and=
 so that is confusing.
>=20
>=20

The way I deal with the syscall wrappers is that I assume the naming makes n=
o sense whatsoever, and I go from there. With this perspective, the patches a=
re neither an improvement nor a worsening of the current situation.

(Similarly, the last column of the tables is useless garbage.  My last attem=
pt to fix that stalled.)=
