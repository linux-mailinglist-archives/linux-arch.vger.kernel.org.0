Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1978B6FC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Aug 2023 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjH1SE6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Aug 2023 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjH1SE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Aug 2023 14:04:56 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665312D;
        Mon, 28 Aug 2023 11:04:54 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57355a16941so1806510eaf.2;
        Mon, 28 Aug 2023 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693245893; x=1693850693;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojSxv79wHQMsfeTbgLB/0/oKnfI9LSWvCqpNwR1k0CI=;
        b=chTb2boVCw41yuBS6QK9ccvZ/dL97jM+EB+QY6tiABAEPYXcoEvi8vY1Q4ClbBb5Q3
         AERyS4vcFfncpiVxZVAMyY1krkQUQKQjexnM8bNs5J9JwKRDJ8VIpnMeJ6lfsAaZsco1
         NzavUnPFiRkg1t/nCOFFDkeyJlybN7SviMiJixjg/5LobTbdER3ORINT51GCDH8OmSWO
         OKzn8s9lkn3TtEO3DyS0dg0jBmMrfg3vTNOyXs9IbbKnTcHGUAmiWlUf/MPiABystBE6
         ZqleURihKrc9qtEr7yEXJSvCaN86pUD4IQNn4uyoxP4lCEy9V5EtkHg9s1aLsYqEf3bs
         qMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245893; x=1693850693;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojSxv79wHQMsfeTbgLB/0/oKnfI9LSWvCqpNwR1k0CI=;
        b=D0snGj9bBZg8nSnX5ITP1GjnlcV6eUC3Qwho5yzVHq8ncR670YtlXgSd9f6hYOgJdD
         1+n6xK2pW4TMhVWBgp/8uwMMTCCqnS+Hapwf62a/glvqYVXHY7MjOToO/Bo9uEMWAlCZ
         5lMM4Vm39zBJ2Y4QuOaY0gYHtj+x3lEwpO/e+H3clLj3Uw1G2ZGAv7ZJVlUpxrpf+NEL
         WTk29+bFis6rgAOOEGdGN/eaxBVh6qzUGjFCx8FLcrjP8uOCPX4KmlyEVKHqoOButR41
         397J6LZfn7++dT4rOnduM6x/31Zd67tGsZUR6LX+S9BJyaJmZiWwP64c7I7hNWnHPqLy
         PWlw==
X-Gm-Message-State: AOJu0YwU0UKVRMQg0B6uobElDGlcOIxVUGuSgPbiKL9eqOZLNPoEyJF3
        rqAdpesvlPBlA2piRUhQGQseF5QC91+ALWDVYzDlEtgs
X-Google-Smtp-Source: AGHT+IH/TG63PAZtXL/cjEgVrtiDVk49PCnWuBOiq9aE7Mb0u+O/GjmNvlD0kbTR6cBR+TzRQMz/iG65d2u76uKswNk=
X-Received: by 2002:a4a:255a:0:b0:573:4da2:4427 with SMTP id
 v26-20020a4a255a000000b005734da24427mr7308192ooe.7.1693245893352; Mon, 28 Aug
 2023 11:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Mon, 28 Aug 2023
 11:04:52 -0700 (PDT)
In-Reply-To: <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 28 Aug 2023 20:04:52 +0200
Message-ID: <CAGudoHGGXNP5dBpZLadBUTVeD-JPEuikQXONruJzvnRJrp5+KA@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/28/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 28 Aug 2023 at 10:07, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> While here make sure labels are unique.
>
> I'll take a look at the other changes later, but this one I reacted
> to: please don't do this.
>
> It's a disaster. It makes people make up random numbers, and then
> pointlessly change them if the code moves around etc.
>
> Numeric labels should make sense *locally*.  The way to disambiguate
> them is to have each use just have "f" and 'b" to distinguish whether
> it refers forward or backwards.
>
[snip]

Other files do it (e.g., see __copy_user_nocache), but I have no
strong opinion myself.

That said I'll wait for the rest of the review before sending a v2.

-- 
Mateusz Guzik <mjguzik gmail.com>
