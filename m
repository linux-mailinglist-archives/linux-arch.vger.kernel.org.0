Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8E6935D8
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 04:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBLDf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 22:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBLDf6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 22:35:58 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B214494
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 19:35:56 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i1so6357341qvo.9
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 19:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/qH6i65wbwYMWKkSUGs3ut6x3jSZ12DHRH6t670lp8=;
        b=hCejaD+8ZOvRc26yk9fa4xQjZArmepS8a/Epauf5WcDpJwNw3VyOwDkWRR5a9e47S0
         mvfjat+pRsBUXfc4YuLVUd2ZvdWpt0Zia4WtQSo0f4/8oXY0Tju7LNbbjKxNi2XMLoc3
         xktqhXuoLmIRLuB47u5svoI2rJAxCN3bF+dFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/qH6i65wbwYMWKkSUGs3ut6x3jSZ12DHRH6t670lp8=;
        b=g1CZB5RO8yjDGPgHXQSh5K6xdmD5fBHvN0fBfdHaN5iCYBEzG8qZ2J3wLJxufPdWML
         OqytnMZhVVHeH7+KA4CG87i+Ha6oOT0OM1LPdHpzUDA4NflSN4XOJUKe5eEg5xogvTRT
         796q8E7p9nh/q0ZZwvyGYxVAumh2QIM32PXpqcxmkh9+O1mgOiTmKXzo39tCtPlLkKTd
         AjpCTz4BNoshiU3oLXss/uoGA0iIfEk0Y0VLUfnJ2dBFCK4OLELeocmvHrFKsnsGDRL/
         16Wvl1cUIgZzMPe9dDhMzcd9PbRVWhFpiBW2LPj1z+3JsCnhFLhRm3Hb+1d3FCEQRJy6
         j7CQ==
X-Gm-Message-State: AO0yUKW8BJFXwdeDJXRU5xrKjv74NM/oHIqLfAAB6/bHDsOMTIqqXaeT
        OWju10LZnhp64eoqpbRScC0trg==
X-Google-Smtp-Source: AK7set8FxOwS2mxztBcIBPmwz4J8siwg4oixkjjVzYbLDpJMmdhkBIfpOxJ/lO2EWgO+mSF1kCkh9w==
X-Received: by 2002:a05:6214:260f:b0:56b:fe6a:df87 with SMTP id gu15-20020a056214260f00b0056bfe6adf87mr39357522qvb.52.1676172955896;
        Sat, 11 Feb 2023 19:35:55 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b84a:b7b1:f9b7:db29:7194:1610])
        by smtp.gmail.com with ESMTPSA id t3-20020a379103000000b0070617deb4b7sm6830212qkd.134.2023.02.11.19.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 19:35:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Current LKMM patch disposition
Date:   Sat, 11 Feb 2023 22:35:44 -0500
Message-Id: <478E76E6-8DA4-4F55-B789-8D8DE0FE6621@joelfernandes.org>
References: <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
In-Reply-To: <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Feb 11, 2023, at 9:59 PM, Alan Stern <stern@rowland.harvard.edu> wrote:=

>=20
> =EF=BB=BFOn Sat, Feb 11, 2023 at 07:30:32PM -0500, Joel Fernandes wrote:
>>> On Sat, Feb 11, 2023 at 3:19 PM Alan Stern <stern@rowland.harvard.edu> w=
rote:
>>> The idea is that the value returned by srcu_read_lock() can be stored to=

>>> and loaded from a sequence (possibly of length 0) of variables, and the
>>> final load gets fed to srcu_read_unlock().  That's what the original
>>> version of the code expresses.
>>=20
>> Now I understand it somewhat, and I see where I went wrong. Basically,
>> you were trying to sequence zero or one "data + rf sequence" starting
>> from lock and unlock with a final "data" sequence. That data sequence
>> can be between the srcu-lock and srcu-unlock itself, in case where the
>> lock/unlock happened on the same CPU.
>=20
> In which case the sequence has length 0.  Exactly right.

Got it.

>=20
>> Damn, that's really complicated.. and I still don't fully understand it.
>=20
> It sounds like you've made an excellent start.  :-)

Thanks. :-)

>=20
>> In trying to understand your CAT code, I made some assumptions about
>> your formulas by reverse engineering the CAT code with the tests,
>> which is kind of my point that it is extremely hard to read CAT. That
>=20
> I can't argue against that; it _is_ hard.  It helps to have had the=20
> right kind of training beforehand (my degree was in mathematical logic).

Got it, I am reviewing the academic material on these as well.

>> is kind of why I want to understand the CAT, because for me
>> explanation.txt is too much at a higher level to get a proper
>> understanding of the memory model.. I tried re-reading explanation.txt
>> many times.. then I realized I am just rewriting my own condensed set
>> of notes every few months.
>=20
> Would you like to post a few examples showing some of the most difficult=20=

> points you encountered?  Maybe explanation.txt can be improved.

Sure, I will share some things I faced difficult with, tomorrow or so. Off t=
he top, cumulativity was certainly pretty hard to parse.

>=20
>>> I'm not sure that breaking this relation up into pieces will make it any=

>>> easier to understand.
>>=20
>> Yes, but I tried. I will keep trying to understand your last patch
>> more. Especially I am still not sure, why in the case of an SRCU
>> reader on a single CPU, the following does not work:
>> let srcu-rscs =3D ([Srcu-lock]; data; [Srcu-unlock]).
>=20
> You have to understand that herd7 does not track dependencies through=20
> stores and subsequent loads.  That is, if you have something like:
>=20
>    r1 =3D READ_ONCE(*x);
>    WRITE_ONCE(*y, r1);
>    r2 =3D READ_ONCE(*y);
>    WRITE_ONCE(*z, r2);
>=20
> then herd7 will realize that the write to y depends on the value read=20
> from x, and it will realize that the write to z depends on the value=20
> read from y.  But it will not realize that the write to z depends on the=20=

> value read from x; it loses track of that dependency because of the=20
> intervening store/load from y.
>=20
> More to the point, if you have:
>=20
>    r1 =3D srcu_read_lock(lock);
>    WRITE_ONCE(*y, r1);
>    r2 =3D READ_ONCE(*y);
>    srcu_read_unlock(lock, r2);
>=20
> then herd7 will not realize that the value of r2 depends on the value of=20=

> r1.  So there will be no data dependency from the srcu_read_lock() to=20
> the srcu_read_unlock().

Got it!  Now I understand why the intermediate load stores needs to be model=
ed with your carry-srcu-data formula, even on the same CPU! Thank you so muc=
h Alan!!

Thanks,

 - Joel

>=20
> Alan
