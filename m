Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD84D3B81
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiCIU7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Mar 2022 15:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiCIU7W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2022 15:59:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E783B572
        for <linux-arch@vger.kernel.org>; Wed,  9 Mar 2022 12:58:22 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z26so4966542lji.8
        for <linux-arch@vger.kernel.org>; Wed, 09 Mar 2022 12:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb1xRrIzaTsXw5ggh9HnMsREf0OUT8EznCjFLR6Tke0=;
        b=XZFXja1i5rQb5XdOAmekW9zg/6hHAdnoz1qTfYcCGVqEela6f+IXzW/TDT5tOM1/lY
         mnlzGppp2H6pBA/Un3GU+l/f2ye3YXwiPbEstAnFSeyuj9kJFvMZCgVXKfit2c0fgo2B
         ZVSmJ5e2eppMQoSI6c9JeU6WDhCTVZwrMtOXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb1xRrIzaTsXw5ggh9HnMsREf0OUT8EznCjFLR6Tke0=;
        b=J3hnZg0gOKvIcukXxwCVfoNGAbKIb3xiObCJ7tYB4OaJNCZ3f65D8LAf8G97izpMFE
         I0W2tCUrQfk6yve7iZ8Oj75El/f9q+Scu5pQ7wxTqxMhKhd3FtG3M/goFwf40WuKH/vL
         JoNV69xiaebwKWR4/zvlWZXBFzvUNmY6RRshbKGzP15QqzmBcm7+9qlw01vr8phJs2Z7
         7jMdWo6qtr9BGcNxNV59DuzU/KCBwUNIjD9tGSFaqFDIAd7pOC30N/QDSlche4TfdoO+
         2YQjGQ9CPRZECV1TFINp5w2aTM7VEustsTW9CNFRNzRyublHeAkU7uE8hKop1JZVbQwU
         Yw0Q==
X-Gm-Message-State: AOAM532QnJTsmwzR7nGODKRvuuzUhpTyGGUvj8OBYcPMdfTqhoiUL5ja
        /rPfFf0dr/RGsTjQ+f5qAYZ+ogscpTVStv79Dnc=
X-Google-Smtp-Source: ABdhPJzJKxgjHxBOyOzSbVv6e2JUt7za5jsJmmL4KVQGxrbMgXax4oAckIqpPAy6QfZp51dVHovgww==
X-Received: by 2002:a2e:a408:0:b0:246:35dd:c242 with SMTP id p8-20020a2ea408000000b0024635ddc242mr905485ljn.197.1646859500570;
        Wed, 09 Mar 2022 12:58:20 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w7-20020a194907000000b0044828c52479sm576900lfa.198.2022.03.09.12.58.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:58:18 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id n19so5926280lfh.8
        for <linux-arch@vger.kernel.org>; Wed, 09 Mar 2022 12:58:17 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr940626lfi.52.1646859496995; Wed, 09 Mar
 2022 12:58:16 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:58:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHmg7UGPotZpvWsztW-p75yFCSNxwyAkBq1-OzuOZrMQ@mail.gmail.com>
Message-ID: <CAHk-=wjHmg7UGPotZpvWsztW-p75yFCSNxwyAkBq1-OzuOZrMQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Removing tracehook.h
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 8, 2022 at 4:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> While working on cleaning up do_exit I have been having to deal with the
> code in tracehook.h.  Unfortunately the code in tracehook.h does not
> make sense as organized. [...]

Thanks, that odd naming has tripped me up several times, this looks
like an improvement.

                  Linus
