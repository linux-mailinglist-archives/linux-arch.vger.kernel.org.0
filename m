Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6B22560C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGTDDJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 23:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTDDJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 23:03:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE72C0619D2;
        Sun, 19 Jul 2020 20:03:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so8339881pfn.9;
        Sun, 19 Jul 2020 20:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lpszrUk3g++VjwDkyO+kB0nakBB1oFxNo5alny9wgU0=;
        b=myC+IRvRSrv66HdgEQPlUWHOsZTOJPaMknWaQKmuH5kea7GMJebrhfBfK5shocJ7PE
         PbTFzBcDYU6JsNuY0veglvqtKVZRc2OdteWXoXs6j1LUMLCxWBGNex5bm7LZAznIww+M
         DedHXMjUF0Hhn3VXVH6FSTFq7opNi8xo0u1GLPHi0XR+wLucj198wmueAIfPYaYh/8Fg
         8jlF5d8e7TD837BcvSgddivhN74F2jWyzVvtNisugRI1YKExssY/BOpG2zSuAIz/rjwL
         q3Nr+g54MEA0pJwLAnuUqZILGu8bacFa705Ph3pT0sYF0FPwYnzyfXi4jHkqUTeM/gm0
         BqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lpszrUk3g++VjwDkyO+kB0nakBB1oFxNo5alny9wgU0=;
        b=NkRrWLPtgcOSzPrmXjckX9ROSAOWSiCMVHUyhlNsG+rQNYF2OyRBgQpe6p76FuoqnL
         e3DP5XY98nnyf+4ReTfO/+Gcu1TwEW/m+i3zFEavaGMHu+b0tCi033dMa04LurtZOmdr
         7s4K4k5mvG2ZOZBp4HBClNazzFRqmjsacRSS9XDz79wX/Dwj+B0gAAb8+hlwQk0196Hf
         wLtxZpOQqeC/IrPIiaUy6MzhN+q6BqY9reZNeFcu+Dr7MurK8knVZRRMwAJCBK2HCTF+
         hvpu3wkxWxJTPs2Hr2tCaZH04L2RrnP28d/iKMi6Wv6Xg4wFzb9yoqJHeZHEXksufLmK
         nqyQ==
X-Gm-Message-State: AOAM531UVCqmJXd6otWtAfAqA4J9CvQROtsY+OYisSNPspgjpc+D55e+
        C2ktY/IHYZ0NyGtRHWoFLvM=
X-Google-Smtp-Source: ABdhPJwMg06qZ+4wVzgvV5FRM4DFOwuOxF3uoQRaPM8dKXqbFpuZN/leQ1NFOn0AUHknX5kL6q7syw==
X-Received: by 2002:a63:d02:: with SMTP id c2mr16849420pgl.338.1595214188892;
        Sun, 19 Jul 2020 20:03:08 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id u66sm14887329pfb.191.2020.07.19.20.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 20:03:08 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:03:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
        <1594892300.mxnq3b9a77.astroid@bobo.none>
        <20200716110038.GA119549@hirez.programming.kicks-ass.net>
        <1594906688.ikv6r4gznx.astroid@bobo.none>
        <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
In-Reply-To: <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Message-Id: <1595213677.kxru89dqy2.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 17, 2020 11:42 pm:
> ----- On Jul 16, 2020, at 7:26 PM, Nicholas Piggin npiggin@gmail.com wrot=
e:
> [...]
>>=20
>> membarrier does replace barrier instructions on remote CPUs, which do
>> order accesses performed by the kernel on the user address space. So
>> membarrier should too I guess.
>>=20
>> Normal process context accesses like read(2) will do so because they
>> don't get filtered out from IPIs, but kernel threads using the mm may
>> not.
>=20
> But it should not be an issue, because membarrier's ordering is only with=
 respect
> to submit and completion of io_uring requests, which are performed throug=
h
> system calls from the context of user-space threads, which are called fro=
m the
> right mm.

Is that true? Can io completions be written into an address space via a
kernel thread? I don't know the io_uring code well but it looks like=20
that's asynchonously using the user mm context.

How about other memory accesses via kthread_use_mm? Presumably there is=20
still ordering requirement there for membarrier, so I really think
it's a fragile interface with no real way for the user to know how=20
kernel threads may use its mm for any particular reason, so membarrier
should synchronize all possible kernel users as well.

Thanks,
Nick
