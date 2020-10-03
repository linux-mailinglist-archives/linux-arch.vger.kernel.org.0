Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465E7282503
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgJCPQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJCPQl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 11:16:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC289C0613D0;
        Sat,  3 Oct 2020 08:16:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nl2so801650pjb.1;
        Sat, 03 Oct 2020 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AWToDGi9VFGS/DA0WK0XAC/g7pGoXnJI85oX3vgFGHs=;
        b=AMiOo/8mSsXqmFoyts2oGRiPw9+Dzq0MMVwY9VhCGiUHVNUA7V3du498Tc151NdxWV
         kmtLxlbSMQaUvnzbgbXyxpTgn7ydFppM0I9kgg3YsoUj0ntJ64qWDRwyVgLz6DLYU9F8
         TcDkdfpHiJbvzvz550p/BzxCH95hkfLUT8FBfrt/frNKFUGprqfmKt2cMdvXPDlkH9Ct
         7Rp92+kkQtNygt7FsUlxrODrhapRS+UJD0GJzZE2omRppdgk4zRNa89iY6GGxMJm7dIj
         tpygy4Lo1DTxzbRMxRfX6umibGRkj3rKWS7mGewVlktqK0ANvzSHu9cCJ+4L0LInNK5C
         AoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWToDGi9VFGS/DA0WK0XAC/g7pGoXnJI85oX3vgFGHs=;
        b=Rak/INzXv7/hMB5l6SmybQEClC+grw5negr9gexTZg+5rE0/+StcEoCySBltRJqgw9
         Sgft0dAQ6WJDpUqDtMNb5K2cj2C3qtEHJZ0kkTWWp1h5Cc3xDcCv34HYAkkoYsg5cHlu
         td6lAtboBC1MbSYVaK3BpxMikpbpw+X+rIhKiuYPRk3S+/qWOBjjkVnBTB2r6iFs+kaw
         r6zs62IzZwZ6MarN9yx9I3ySAL45W6OIs7br0gp39ppllV4G7GhPHrXBImgvHKWFr/Mq
         Xld+Spe6aLULG1k4/4OBg9NV0MwtZvCHfgxPW5owxV6DqWTSoICN7xWhN4tknd4y++Tx
         cYOQ==
X-Gm-Message-State: AOAM531dFjoL5LmeqK5rCzrNCb1Iiw/cTklRXUjN7TARU3KGHfgt2hRZ
        1GUkXLO7qoe+MIqvWHuXbH4=
X-Google-Smtp-Source: ABdhPJxFaw7yeqEVcj7Yh0vzTlFn8p1lnEFl3nSi8F72nv81BUItSKik5wjDO1AgKcQRrgPZ+xmQ2Q==
X-Received: by 2002:a17:90b:1902:: with SMTP id mp2mr8239031pjb.176.1601738198972;
        Sat, 03 Oct 2020 08:16:38 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h9sm5293089pgk.52.2020.10.03.08.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 08:16:38 -0700 (PDT)
Subject: Re: Litmus test for question from Al Viro
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, dlustig@nvidia.com,
        joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
Date:   Sun, 4 Oct 2020 00:16:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003132212.GB318272@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alan,

Just a minor nit in the litmus test.

On Sat, 3 Oct 2020 09:22:12 -0400, Alan Stern wrote:
> To expand on my statement about the LKMM's weakness regarding control 
> constructs, here is a litmus test to illustrate the issue.  You might 
> want to add this to one of the archives.
> 
> Alan
> 
> C crypto-control-data
> (*
>  * LB plus crypto-control-data plus data
>  *
>  * Expected result: allowed
>  *
>  * This is an example of OOTA and we would like it to be forbidden.
>  * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
>  * control-dependent on the preceding READ_ONCE.  But the dependencies are
>  * hidden by the form of the conditional control construct, hence the 
>  * name "crypto-control-data".  The memory model doesn't recognize them.
>  *)
> 
> {}
> 
> P0(int *x, int *y)
> {
> 	int r1;
> 
> 	r1 = 1;
> 	if (READ_ONCE(*x) == 0)
> 		r1 = 0;
> 	WRITE_ONCE(*y, r1);
> }
> 
> P1(int *x, int *y)
> {
> 	WRITE_ONCE(*x, READ_ONCE(*y));

Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.

When I changed P1 to

P1(int *x, int *y)
{
	int r1;

	r1 = READ_ONCE(*y);
	WRITE_ONCE(*x, r1);
}

and replaced the WRITE_ONCE() in P0 with smp_store_release(),
I got the result of:

-----
Test crypto-control-data Allowed
States 1
0:r1=0;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (0:r1=1)
Observation crypto-control-data Never 0 3
Time crypto-control-data 0.01
Hash=9b9aebbaf945dad8183d2be0ccb88e11
-----

Restoring the WRITE_ONCE() in P0, I got the result of:

-----
Test crypto-control-data Allowed
States 2
0:r1=0;
0:r1=1;
Ok
Witnesses
Positive: 1 Negative: 4
Condition exists (0:r1=1)
Observation crypto-control-data Sometimes 1 4
Time crypto-control-data 0.01
Hash=843eaa4974cec0efae79ce3cb73a1278
-----

As this is the same as the expected result, I suppose you have missed another
limitation of herd7 + LKMM.

By the way, I think this weakness on control dependency + data dependency
deserves an entry in tools/memory-model/Documentation/litmus-tests.txt.

In the LIMITATIONS section, item #1 mentions some situation where
LKMM may not recognize possible losses of control-dependencies by
compiler optimizations.

What this litmus test demonstrates is a different class of mismatch.

Alan, can you come up with an update in this regard?

        Thanks, Akira

> }
> 
> exists (0:r1=1)
> 
