Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBB1E3266
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391595AbgEZWXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 18:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389382AbgEZWXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 18:23:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB357C061A0F;
        Tue, 26 May 2020 15:23:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so10821745pfk.12;
        Tue, 26 May 2020 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g70fzYswEC8HrYqT6MEAf4OLxXoMz4BqVHGqp/tb5jI=;
        b=QuwxUqpiqAKsubBszgvzAdntvuvl+6RVP4dlKUG5jZQktdEmErRwK6l+F5VjwxVq6P
         44A0tu4Dk5sX3Krp+K9vzk+IJoMPQ6WkOxCE+FfNz3alARAadkV+4UDE0rhT+5RQONgm
         DZjfbcS9YprBlOH4LEw8w/M+j1qFBXpgf7RCD1/zzS1bAsav/P48luhNo4MFbisNlk6E
         K47Db7YuA52V+mAL3HoOcJfKPF1pzEhNJy+Ga39Y1C5N6qiE0ILTQhv3BBD5YTcuCkiV
         l1HfvO93JsxAR6vPfislP/JMFVoLNVzQlbrW7UNRlbMDlEuK+899rKRQ387zFOXaqlp3
         LAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g70fzYswEC8HrYqT6MEAf4OLxXoMz4BqVHGqp/tb5jI=;
        b=ezElZzMczHHpbSQgBRMf48nnzweuzdsbd/IjZh7hPBj42AenO85nWOYOx0Oow5qDOo
         SeXxyaUvE6MWiED/KIgDKWf+L7s5/jwBqTmWE+NIAgN1r+0fXXlzsgnrXZhBN5JIWwK/
         1evchYfiwn6P+JuRTYdHuMgiQexpIHGLks3OkORP03ePfJ7XAcKbSOx6me901PKvb6AK
         qrFYC0sJiwI7jWC+RMDbQngEFs3XqIxSqIVlIryz+AIFNVTVlVWPHHrEOPokxyGqPAGW
         iNVlnqz+7PVA2r80fzkLvKfpUgFctyy2Wyc9TZti+j0psqdvkUlylcTF1ltM4NKmORr+
         NXlg==
X-Gm-Message-State: AOAM532v2NmjQV9r4yziYyTZhCsdPf66cyLYuCt5riGeMwpBGvEIzg3U
        ddx6O5nBKQAGvGbA3KropzQsz92ciVc=
X-Google-Smtp-Source: ABdhPJz/MfMI3dIM8HjADVKC8SJmSd++dFtFBjajoAEp1B8ZfQAylAu+XKAPph7dj2hODmA788+hdA==
X-Received: by 2002:a63:504d:: with SMTP id q13mr985857pgl.330.1590531809784;
        Tue, 26 May 2020 15:23:29 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y18sm443907pfr.100.2020.05.26.15.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:23:29 -0700 (PDT)
Subject: Re: Some -serious- BPF-related litmus tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     luc.maranget@inria.fr, Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, Joel Fernandes <joel@joelfernandes.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
 <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com>
 <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com>
 <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
 <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com>
 <CAEf4BzZ0mCmUomn0poLk_ADJs9J-fZ0Um6QEqwg1TUL86TtgUg@mail.gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ce622dcb-9527-8450-6cc3-ed068a5313c3@gmail.com>
Date:   Wed, 27 May 2020 07:23:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZ0mCmUomn0poLk_ADJs9J-fZ0Um6QEqwg1TUL86TtgUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 26 May 2020 13:15:49 -0700, Andrii Nakryiko wrote:
> On Tue, May 26, 2020 at 3:50 AM Akira Yokosawa <akiyks@gmail.com> wrote=
:
>>
>> On Mon, 25 May 2020 16:31:05 -0700, Andrii Nakryiko wrote:
>>> On Mon, May 25, 2020 at 3:01 PM Akira Yokosawa <akiyks@gmail.com> wro=
te:
>>>>
>> [...]
>>>> Yes, that should work.
>>>
>>> Ok, assigning to zero didn't work (it still complained about
>>> uninitialized read), but using a separate int *lenFail to assign to
>>> rLenPtr worked. Curiously, if I used rLenPtr =3D len1; in error case,=
 it
>>> actually takes a bit more time to verify.
>>>
>>> So I've converted everything else as you suggested. I compiled latest=

>>> herd7 and it doesn't produce any warnings. But it's also extremely
>>> slow, compared to the herd7 that I get by default. Validating simple
>>> 1p1c cases takes about 2.5x times longer (0.03s vs 0.07), but trying
>>> to validate 2p1c case, which normally validates in 42s (unbounded) an=
d
>>> 110s (bounded), it took more than 20 minutes and hasn't finished,
>>> before I gave up. So I don't know what's going on there...
>>
>> herdtools7 has recently been heavily restructured.
>> On the performance regression, I must defer to Luc.
>>
>> Luc, do you have any idea?
>>
>>>
>>> As for klitmus7, I managed to generate everything without warnings,
>>> but couldn't make it build completely due to:
>>>
>>> $ make
>>> make -C /lib/modules/5.6.13-01802-g938d64da97c6/build/
>>
>> So you are on Linux 5.6.x which requires cutting-edge klitmus7.
>>
>=20
> Right, so I retried with the klitmus7 built from sources:
>=20
> $ klitmus7 -version
>=20
>                                     7.55+01(dev)
>=20
> Still can't compile, though task_struct problem went away, proc_ops
> error is still present:
>=20
> $ make
> grep: /lib/modules/5.7.0-rc5-02014-gb16540c748e9/build/include/linux/pr=
oc_fs.h:
> No such file or directory

Hmm, have you installed kernel-headers on your system?
You are now on Linux 5.7-rc5 based system...

        Thanks, Akira

> make -C /lib/modules/5.7.0-rc5-02014-gb16540c748e9/build/
> M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules module=
s
> make[1]: Entering directory `/data/users/andriin/linux-build/fb-config'=

> make[2]: Entering directory `/data/users/andriin/linux-build/default-x8=
6_64'
> grep: /lib/modules/5.7.0-rc5-02014-gb16540c748e9/build/include/linux/pr=
oc_fs.h:
> No such file or directory
>   CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodules/=
litmus000.o
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:
> In function =E2=80=98litmus_init=E2=80=99:
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:621:67:
> error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incompa=
tible pointer
> type [-Werror=3Dincompatible-pointer-types]
>    struct proc_dir_entry *litmus_pde =3D
> proc_create("litmus",0,NULL,&litmus_proc_ops);
>=20
> ^~~~~~~~~~~~~~~~
> In file included from
> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:15:
> /data/users/andriin/linux/include/linux/proc_fs.h:79:24: note:
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
> Don't know if I'm missing some headers or whatever.
>=20
>>> M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules modu=
les
>>> make[1]: Entering directory `/data/users/andriin/linux-build/fb-confi=
g'
>>> make[2]: Entering directory `/data/users/andriin/linux-build/default-=
x86_64'
>>>   CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodule=
s/litmus000.o
>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus00=
0.c:
>>> In function =E2=80=98zyva=E2=80=99:
>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus00=
0.c:507:12:
>>> warning: ISO C90 forbids variable length array =E2=80=98th=E2=80=99 [=
-Wvla]
>>>      struct task_struct *th[nth];
>>>             ^~~~~~~~~~~
>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus00=
0.c:
>>> In function =E2=80=98litmus_init=E2=80=99:
>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus00=
0.c:605:67:
>>> error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incom=
patible pointer
>>> type [-Werror=3Dincompatible-pointer-types]
>>>    struct proc_dir_entry *litmus_pde =3D
>>> proc_create("litmus",0,NULL,&litmus_proc_fops);
>>>
>>> ^~~~~~~~~~~~~~~~~
>>> In file included from
>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus00=
0.c:15:
>>> /data/users/andriin/linux-fb/include/linux/proc_fs.h:64:24: note:
>>> expected =E2=80=98const struct proc_ops *=E2=80=99 but argument is of=
 type =E2=80=98const
>>> struct file_operations *=E2=80=99
>>>  struct proc_dir_entry *proc_create(const char *name, umode_t mode,
>>> struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
>>>                         ^~~~~~~~~~~
>>> cc1: some warnings being treated as errors
>>> make[3]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymo=
dules/litmus000.o]
>>> Error 1
>>> make[2]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymo=
dules]
>>> Error 2
>>> make[2]: Leaving directory `/data/users/andriin/linux-build/default-x=
86_64'
>>> make[1]: *** [sub-make] Error 2
>>> make[1]: Leaving directory `/data/users/andriin/linux-build/fb-config=
'
>>> make: *** [all] Error 2
>>>
>>
>> These errors suggest the klitmus7 you used is version 7.52 or some suc=
h.
>> You said you have built herd7 from the source.  Have you also built kl=
itmus7?
>=20
> I did, but it wasn't in the PATH. I retried with latest klitmus7 and
> still run into problems.
>=20
>>
>> The up-to-date klitmus7 should generate code compatible with Linux 5.6=
=2Ex.
>>
>> Could you try with the latest one?
>>
>>         Thanks, Akira
>>
>>>
>>> But at least it doesn't complain about atomic_t anymore. So anyways,
>>> I'm going to post updated litmus tests separately from BPF ringbuf
>>> patches, because Documentation/litmus-tests is not yet present in
>>> bpf-next.
>>>
>>>>
>>>> You can find a basic introduction of klitmus7 in tools/memory-model/=
README.
>>>>
>>>>         Thanks, Akira
>>>>
>>>>>
>>>>>>
>>>>>> Please note that if you are on Linux 5.6 (or later), you need an u=
p-to-date
>>>>>> klitmus7 due to a change in kernel API.
>>>>>>
>>>>>> Any question is welcome!
>>>>>>
>>>>>>         Thanks, Akira
>>>>>>
>>>
>>> [...]
>>>
>>

