Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977877B90A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHNMvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjHNMuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 08:50:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076DE5E;
        Mon, 14 Aug 2023 05:50:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3C48537B;
        Mon, 14 Aug 2023 12:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C48537B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692017451; bh=Y7np9sBzz3ulx4HSM0NvWuYOFiMGgmI3bxnlJ4kzrzg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=N6/AGRbeJW50Rlr8/b5roDoQ69Th4jn001HwPl3porEmJ3OtMIcJg+wNcwOdkex9e
         AOMdP3yG/XwvoXVHCWv0vA12qj6IQva7f4RuzJtF2kX5X5sdd8dcfLFPl/5BikhIYp
         51x85myRx98jhcm83HWKMA8YgG98eZ6xoK6OcvZAhXrOWRVYg/DxX4NF4obpU5MkER
         9CRKn3OhMguWCiSJyHFeH/XbEF1xkVsZAG4HKp2byjgIA4sghdR2KRsKp0oD3h9/yy
         RcL61vvcwgVgui5Mkg0BbKWyYUg3yAaVeYSJ6EK6BkNrVX1LTggAVUlrHIOr+bx4db
         hzdU12X1nV+rw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yanteng Si <siyanteng@loongson.cn>, Gang Li <gang.li@linux.dev>
Cc:     Alex Shi <alexs@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
In-Reply-To: <479156cf-1bdb-421a-8dab-0db8ff73012b@loongson.cn>
References: <20230811080851.84497-1-gang.li@linux.dev>
 <2f519a69-8f12-4c07-bf20-6776a5ada256@loongson.cn>
 <f8de40bf-1743-793f-7723-232adbfab623@linux.dev>
 <479156cf-1bdb-421a-8dab-0db8ff73012b@loongson.cn>
Date:   Mon, 14 Aug 2023 06:50:50 -0600
Message-ID: <87o7j9wzx1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Yanteng Si <siyanteng@loongson.cn> writes:

> =E5=9C=A8 2023/8/14 10:40, Gang Li =E5=86=99=E9=81=93:
>> Hi,
>>
>> On 2023/8/12 19:00, Yanteng Si wrote:
>>> =E5=9C=A8 2023/8/11 16:08, Gang Li =E5=86=99=E9=81=93:
>>>> +=E8=AF=91=E6=B3=A8=EF=BC=9A
>>>> +=E6=9C=AC=E6=96=87=E4=BB=85=E4=B8=BA=E6=96=B9=E4=BE=BF=E6=B1=89=E8=AF=
=AD=E9=98=85=E8=AF=BB=EF=BC=8C=E4=B8=8D=E4=BF=9D=E8=AF=81=E4=B8=8E=E8=8B=B1=
=E6=96=87=E7=89=88=E6=9C=AC=E5=90=8C=E6=AD=A5;
>>>> +=E8=8B=A5=E6=9C=89=E7=96=91=E9=97=AE=EF=BC=8C=E8=AF=B7=E9=98=85=E8=AF=
=BB=E8=8B=B1=E6=96=87=E7=89=88=E6=9C=AC;
>>>> +=E8=8B=A5=E6=9C=89=E7=BF=BB=E8=AF=91=E9=97=AE=E9=A2=98=EF=BC=8C=E8=AF=
=B7=E9=80=9A=E7=9F=A5=E8=AF=91=E8=80=85=EF=BC=9B
>>>> +=E8=8B=A5=E6=83=B3=E4=BF=AE=E6=94=B9=E6=96=87=E6=A1=A3=EF=BC=8C=E4=B9=
=9F=E8=AF=B7=E5=85=88=E4=BF=AE=E6=94=B9=E8=8B=B1=E6=96=87=E7=89=88=E6=9C=AC=
=E3=80=82
>>>
>>> In fact, we already have an easier way to do this, just include=20
>>> disclaimer-zh_CN.
>>>
>>> If you observe the files under .../zh_CN/, they all have a similar=20
>>> header, and we can completely follow them.
>>>
>> Thanks. I just noticed that there are txt files under=20
>> "zh_CN/arch/arm64/" and "zh_CN/video4linux/". They have the same=20
>> header, and I will
>> refer to them in v2.
>>
>>> But you should also have noticed that memory-barriers are not a=20
>>> standard rst file and will not be built, which will result in it only=20
>>> staying in the development tree.
>>> It won't appear at:
>> https://docs.kernel.org
>> https://www.kernel.org/doc/html/latest/
>>
>> But people can still access the txt document in this way:
>> https://www.kernel.org/doc/Documentation/memory-barriers.txt
>>
>>> Finally, this patch is too huge and we may need some time to review it.
>>>
>> Of course. Would it be more convenient if I split the file into multiple
>> patches and send them as one series?
> You didn't have to.
>
>
> If you want to send a series, you can refactor the original document=20
> into rst format and make it the first patch of the series.
>
> Just like:
>
> [PATCH=C2=A0 v2 0/2] docs: Refactor=C2=A0memory-barriers.txt and translat=
e it into=20
> Chinese
>
> [PATCH=C2=A0 v2 1/2] docs: convert memory-barriers.txt to RST

For $REASONS, memory-barriers.txt is staying as .txt, thus, as Gang Li
pointed out, the wrapper page that pulls it in.  The proper solution is
to create a wrapper for the translated .txt file as well.

Thanks,

jon
