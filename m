Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3B1E201B
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgEZKuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388524AbgEZKux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 06:50:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6BC03E97E;
        Tue, 26 May 2020 03:50:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so9907623pgv.8;
        Tue, 26 May 2020 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N1bDO4eH+ho6siSE7hU5qjf1ovBjIkZNLyVGGq0NpRc=;
        b=EgZTKHnOpIDLlPNqFD2IlJAVn6OA1hwMmpXPkSeBOtE5446sO+7uroKuWKSBHVID5l
         TZj6IILoy3D2u+O9EMUc0Xzx8fl6DlPxuDPa4O7wW7S4Z6U24K3ZMnir9hQFaa/+2mx8
         Vqi3xfo/1WVvC7HaCNUkPUU7cVNTn5VD1+i0EN5twjvrsx4542bLKLPTQd0e0mg8o7W+
         xSy4U6tUJbxNnaYzEeEjtKE9eFIFTVR3EXj7W15DLRoxj9zeUALyRzzPURdyuwKwHuSk
         +9erYtUxXI9MBrtC4LPjtU4zGHlkRWbBc+sfiWAeyvbkm2iDfAVQOffuFwWhq2Ll0sJi
         ujMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N1bDO4eH+ho6siSE7hU5qjf1ovBjIkZNLyVGGq0NpRc=;
        b=Sm+vqY4aONIsHJuVNNHaw7zG8sXONaFASzuXSgBpF2amvi4Ac5OGCsVndwmNEw7Shh
         8Nc6XZq9sPUQQkYcgdS/BjNJ3tyz49nh/24wuTjjrD8n8aimBH34663s3y1f+hHZg83D
         QdHH+HFJ3ua2mhJqkdvScX0NqR6hMI2vzGFWlAsr8ajT0mGg9pxTdDvvDlV0dg2Pnmay
         CxalN6NSrJ5IDNalhZC5DKLKqKow4hJvURp3VD2y0yFvWSidwIqbGF+cAwBpScgoPQXH
         73ZpFZDaBzgHIyheGAGtmTKeIBwyWfnByeL1grP4eix0PLN/PwZvgI+52/sVK7mDzdQm
         BN2g==
X-Gm-Message-State: AOAM5303//kfb3uJEeJUwDHCDDY6iJW//o48QIe6vxCy9FT9WEIwf4CC
        0oQEFWMDNThmxUDkims/OE8=
X-Google-Smtp-Source: ABdhPJwbxo2CyFzDDHtum2KjSyXJZxpZpD4FjzCo/aydKKN9uV0l2PNil3KEIDagb/K/VFe5Q3CnYQ==
X-Received: by 2002:a65:67d6:: with SMTP id b22mr520316pgs.14.1590490253147;
        Tue, 26 May 2020 03:50:53 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q185sm4525886pfb.82.2020.05.26.03.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 03:50:52 -0700 (PDT)
Subject: Re: Some -serious- BPF-related litmus tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, luc.maranget@inria.fr
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, dlustig@nvidia.com,
        Joel Fernandes <joel@joelfernandes.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
 <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com>
 <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com>
 <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com>
Date:   Tue, 26 May 2020 19:50:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 25 May 2020 16:31:05 -0700, Andrii Nakryiko wrote:
> On Mon, May 25, 2020 at 3:01 PM Akira Yokosawa <akiyks@gmail.com> wrote=
:
>>
[...]
>> Yes, that should work.
>=20
> Ok, assigning to zero didn't work (it still complained about
> uninitialized read), but using a separate int *lenFail to assign to
> rLenPtr worked. Curiously, if I used rLenPtr =3D len1; in error case, i=
t
> actually takes a bit more time to verify.
>=20
> So I've converted everything else as you suggested. I compiled latest
> herd7 and it doesn't produce any warnings. But it's also extremely
> slow, compared to the herd7 that I get by default. Validating simple
> 1p1c cases takes about 2.5x times longer (0.03s vs 0.07), but trying
> to validate 2p1c case, which normally validates in 42s (unbounded) and
> 110s (bounded), it took more than 20 minutes and hasn't finished,
> before I gave up. So I don't know what's going on there...

herdtools7 has recently been heavily restructured.
On the performance regression, I must defer to Luc.

Luc, do you have any idea?

>=20
> As for klitmus7, I managed to generate everything without warnings,
> but couldn't make it build completely due to:
>=20
> $ make
> make -C /lib/modules/5.6.13-01802-g938d64da97c6/build/

So you are on Linux 5.6.x which requires cutting-edge klitmus7.

> M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules module=
s
> make[1]: Entering directory `/data/users/andriin/linux-build/fb-config'=

> make[2]: Entering directory `/data/users/andriin/linux-build/default-x8=
6_64'
>   CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodules/=
litmus000.o
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:
> In function =E2=80=98zyva=E2=80=99:
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:507:12:
> warning: ISO C90 forbids variable length array =E2=80=98th=E2=80=99 [-W=
vla]
>      struct task_struct *th[nth];
>             ^~~~~~~~~~~
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:
> In function =E2=80=98litmus_init=E2=80=99:
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:605:67:
> error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incompa=
tible pointer
> type [-Werror=3Dincompatible-pointer-types]
>    struct proc_dir_entry *litmus_pde =3D
> proc_create("litmus",0,NULL,&litmus_proc_fops);
>=20
> ^~~~~~~~~~~~~~~~~
> In file included from
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:15:
> /data/users/andriin/linux-fb/include/linux/proc_fs.h:64:24: note:
> expected =E2=80=98const struct proc_ops *=E2=80=99 but argument is of t=
ype =E2=80=98const
> struct file_operations *=E2=80=99
>  struct proc_dir_entry *proc_create(const char *name, umode_t mode,
> struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
>                         ^~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymodu=
les/litmus000.o]
> Error 1
> make[2]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymodu=
les]
> Error 2
> make[2]: Leaving directory `/data/users/andriin/linux-build/default-x86=
_64'
> make[1]: *** [sub-make] Error 2
> make[1]: Leaving directory `/data/users/andriin/linux-build/fb-config'
> make: *** [all] Error 2
>=20

These errors suggest the klitmus7 you used is version 7.52 or some such.
You said you have built herd7 from the source.  Have you also built klitm=
us7?

The up-to-date klitmus7 should generate code compatible with Linux 5.6.x.=


Could you try with the latest one?

        Thanks, Akira

>=20
> But at least it doesn't complain about atomic_t anymore. So anyways,
> I'm going to post updated litmus tests separately from BPF ringbuf
> patches, because Documentation/litmus-tests is not yet present in
> bpf-next.
>=20
>>
>> You can find a basic introduction of klitmus7 in tools/memory-model/RE=
ADME.
>>
>>         Thanks, Akira
>>
>>>
>>>>
>>>> Please note that if you are on Linux 5.6 (or later), you need an up-=
to-date
>>>> klitmus7 due to a change in kernel API.
>>>>
>>>> Any question is welcome!
>>>>
>>>>         Thanks, Akira
>>>>
>=20
> [...]
>=20

