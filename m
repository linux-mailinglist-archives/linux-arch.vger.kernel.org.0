Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59847D8EC7
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJ0Gfc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 02:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0Gfb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 02:35:31 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35570121;
        Thu, 26 Oct 2023 23:35:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8216B3200BB7;
        Fri, 27 Oct 2023 02:35:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 02:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698388526; x=1698474926; bh=ijn9LKOmAMUGBGwJHsN1qvv5KR6XAd5/U4/
        K/UeLB/A=; b=HPKdp0vu6TQo9nOWnMSMnIsbdPaZo/7QxPk1qO5P7/ePiud9XNC
        skjx9DUvtpBsAd0Ih/52W5KSD4URW9BYr+TAOXUl88vhxZubblKMBVK2mLWWfwxc
        HpsyOeriLtbdSnNA7T8seXSUHpDI8FZny9u5QRzPWUJ8yNsoKlKD9C7uSIz3x1Vl
        Usj7X9E+jKDiMVxrUdBoxts2Id7TrfennhJghV5WdENLEqCxk4+bAHDi1tTzbJsZ
        0nH9AktgGqkSWK+QWJUx5vezWn3uGrniIuxSS0t9up1l8Xf+qQYG5yuwr6vdbkO6
        qRWnD+Zi524JBvNB+FbcLjqq+kJVs3PbvOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698388526; x=1698474926; bh=ijn9LKOmAMUGBGwJHsN1qvv5KR6XAd5/U4/
        K/UeLB/A=; b=DiBX4/I27Pvac9t3zmkmnSuXducX4QdxI55QsQfLCc0oUP94wqU
        S4N1jNnKzpLFqwEDSflmoanuUwm8qhoteciYVEM5uCcoOl2FE8cUza2uyti3r23U
        KRGZzdVDZ3rLhfb7FaFUi2qpSSRAdprbjhvbQ2SGGmNCWBABnwSWAskDkG4Unlr3
        cd1Le2H8YMJtotYKOQ0brC2U8kSZbUdN6pHecluADE8TCJAhydBJL0Lq4L4WLJpl
        Y5lDYak4Q2Gm/4+20+3UZ3WJrCcjUB3aoTpdVIRqgOFXeRBIucijI4jsgzoBKapG
        7DeMt420YltBYeydd36vxVQN1rvCntZPodw==
X-ME-Sender: <xms:LVo7ZQ6naWEKuEyMOQq660epet943q1h01vGW-KmyI0dg5UN3uj1GQ>
    <xme:LVo7ZR7R8NK55WtpitWZzUtLaGVF0VNS6xVTAWaG1NqY9vzR6sq3Z1Gc1HrHWU1Jl
    o7SY_if_xfRWlkhdDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LVo7ZfdVcu-vGdHfCefrnYG8R69mHw15q8WT0mI2gvIvU_kKxEiTrg>
    <xmx:LVo7ZVLwgWPJ00SMrQfWzZG09vy87ahNqCajtYU7jUfBjb0ZSS3h3g>
    <xmx:LVo7ZULDGADAQ-oxLktDijlM3YRiRIOiXnRmSjHIzQQYgnCAg6xzbQ>
    <xmx:Llo7ZZitSH1LYdKDpuInMAFiXYyHNbaR7uHyDqe2YJEuLiCxRJKiow>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0DD6B60089; Fri, 27 Oct 2023 02:35:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <b20fe713-28c6-4ca8-b64a-df017f161524@app.fastmail.com>
In-Reply-To: <20231026235433.yuvxf7opxg74ncmd@moria.home.lan>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-29-surenb@google.com> <87h6me620j.ffs@tglx>
 <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
 <87jzr93rxv.ffs@tglx> <20231026235433.yuvxf7opxg74ncmd@moria.home.lan>
Date:   Fri, 27 Oct 2023 08:35:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kent Overstreet" <kent.overstreet@linux.dev>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Suren Baghdasaryan" <surenb@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Mel Gorman" <mgorman@suse.de>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Jonathan Corbet" <corbet@lwn.net>, void@manifault.com,
        "Peter Zijlstra" <peterz@infradead.org>, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        peterx@redhat.com, "David Hildenbrand" <david@redhat.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, dennis@kernel.org,
        "Tejun Heo" <tj@kernel.org>, "Muchun Song" <muchun.song@linux.dev>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, pasha.tatashin@soleen.com,
        yosryahmed@google.com, "Yu Zhao" <yuzhao@google.com>,
        "David Howells" <dhowells@redhat.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>, vvvvvv@google.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Eric Biggers" <ebiggers@google.com>, ytcoode@gmail.com,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, "Steven Rostedt" <rostedt@goodmis.org>,
        bsegall@google.com, bristot@redhat.com, vschneid@redhat.com,
        "Christoph Lameter" <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Marco Elver" <elver@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Muchun Song" <songmuchun@bytedance.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "David Rientjes" <rientjes@google.com>, minchan@google.com,
        kaleshsingh@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 27, 2023, at 01:54, Kent Overstreet wrote:
> On Fri, Oct 27, 2023 at 01:05:48AM +0200, Thomas Gleixner wrote:
>> On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
>> > On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linut=
ronix.de> wrote:
>> >> > This avoids a circular header dependency in an upcoming patch by=
 only
>> >> > making hrtimer.h depend on percpu-defs.h
>> >>
>> >> What's the actual dependency problem?
>> >
>> > Sorry for the delay.
>> > When we instrument per-cpu allocations in [1] we need to include
>> > sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
>>=20
>> Including sched.h in percpu.h is fundamentally wrong as sched.h is the
>> initial place of all header recursions.
>>=20
>> There is a reason why a lot of funtionalitiy has been split out of
>> sched.h into seperate headers over time in order to avoid that.
>
> Yeah, it's definitely unfortunate. The issue here is that
> alloc_tag_save() needs task_struct - we have to pull that in for
> alloc_tag_save() to be inline, which we really want.
>
> What if we moved task_struct to its own dedicated header? That might be
> good to do anyways...

Yes, I agree that is the best way to handle it. I've prototyped
a more thorough header cleanup with good results (much improved
build speed) in the past, and most of the work to get there is
to seperate out structures like task_struct, mm_struct, net_device,
etc into headers that only depend on the embedded structure
definitions without needing all the inline functions associated
with them.

      Arnd
