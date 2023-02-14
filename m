Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF650695567
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBNAg6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 19:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjBNAg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 19:36:58 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915857682
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 16:36:56 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id g14so16660043ljh.10
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 16:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9RRqUU5Jw1iTTTZrbAzZsd2v3c9RLx3qyatexye6z8=;
        b=HwodED9j3AXQUWEma/9M+Dz8hlXE4SNsrWn1o1QOqwXmeepJz90TRtgs0lnGM3328Y
         7x6kRKlU4EVr1iso7ZJ/XgvEOLND6jk+qYQn0EGsermmKmvgfvRa1kysyh2tyezzxXn/
         31G8gBsmT6yLImYGUobfRU35o2Dft2/Ah3rFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9RRqUU5Jw1iTTTZrbAzZsd2v3c9RLx3qyatexye6z8=;
        b=pHYYkdVYs+SPgTH3v4CPHQUs6LMhP7zHGFdCZ/n/YOrlPXDYPICw5uLyAGymZh6V5c
         ccBTbQ19QtctfvUjtTPKJiCIK4lLztb/+fnfYiyw9aCgeX2bpb4QzuKJWkfnsGFfteIQ
         +rqNbAAt+AtJfkYf3oGEaUT7psAZw5kxN0nEUaJph3/WsQpZ1nP+YOOK7Dh+AQUL2T/I
         BwYkclHp3uQpoz6CmI3o8vU+kPJUI/KHGnW8+BV0cj54YDjANP+n7jvGmp4ezg6BRARZ
         l71n/ni+EpEAjZZxkKPJmiT2RYGqEKnFXemaCXTsDh3ELaT4XJPo+y5UVGqkgie39dsy
         ZVeg==
X-Gm-Message-State: AO0yUKVNJ8i9405JzZSblFngCPskpoS4mQCV9IuvVaYE615iM8OOubky
        hqSsGfwQGmd8Yl1togsqdY/cj0xAxO14HIuAHT4oug==
X-Google-Smtp-Source: AK7set/xhscjKrY7/co1CiOVX44XxUOdlR0UY5V6dO1zYCJPiTnG35P1VAqhKEzpvdZKeL2EDPOMJc1YrjK8RZS6oR0=
X-Received: by 2002:a05:651c:1581:b0:293:39fe:b712 with SMTP id
 h1-20020a05651c158100b0029339feb712mr43816ljq.3.1676335014888; Mon, 13 Feb
 2023 16:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu> <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
 <Y+ppzKlvzQIE18Hu@rowland.harvard.edu>
In-Reply-To: <Y+ppzKlvzQIE18Hu@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 13 Feb 2023 19:36:42 -0500
Message-ID: <CAEXW_YRc0qtan5hbTFUeP7B8f-q5BQJS_d2TpKqZ8_aX5A=b2g@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks, I agree with most of your last email, just replying to one thing:

> > ->rf does because of data flow causality, ->ppo does because of
> > program structure, so that makes sense to be ->hb.
> >
> > IMHO, ->rfi should as well, because it is embodying a flow of data, so
> > that is a bit confusing. It would be great to clarify more perhaps
> > with an example about why ->rfi cannot be ->hb, in the
> > "happens-before" section.
>
> Maybe.  We do talk about store forwarding, and in fact the ppo section
> already says:
>
> ------------------------------------------------------------------------
>         R ->dep W ->rfi R',
>
> where the dep link can be either an address or a data dependency.  In
> this situation we know it is possible for the CPU to execute R' before
> W, because it can forward the value that W will store to R'.
> ------------------------------------------------------------------------

Thank you for pointing this out! In the text that follows this, in
this paragraph:

<quote>
where the dep link can be either an address or a data dependency.  In
this situation we know it is possible for the CPU to execute R' before
W, because it can forward the value that W will store to R'.  But it
cannot execute R' before R, because it cannot forward the value before
it knows what that value is, or that W and R' do access the same
location.
</quote>

The "in this situation" should be clarified that the "situation" is a
data-dependency. Only in the case of data-dependency,  the ->rfi
cannot cause misordering if I understand it correctly. However, that
sentence does not mention data-dependency explicitly. Or let me know
if I missed something?

Thanks,

 - Joel
