Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB33B2CFB20
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgLELQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 06:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgLELLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 06:11:12 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FAC0613D1
        for <linux-arch@vger.kernel.org>; Sat,  5 Dec 2020 03:10:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r5so8523005eda.12
        for <linux-arch@vger.kernel.org>; Sat, 05 Dec 2020 03:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=284Aswjz/2aC/ESWP2Gvj4AFxGv5jL6flAbPPGxPgBs=;
        b=N8xLr/exrAAFOyKCgcYejTnwi5NhKD9FvXUr2xSuCjk1Zm+/U5r6t2wwz154xabUfm
         Hq40S47ibOK6mrdzy0V8ASiOR4AZbqjDDZh7fAysCYLuYHKLujWexjeO8SI1F6qFfeiN
         q+5rW9/BGZ7uRivpDJLMD7WkXl6JAVT618TZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=284Aswjz/2aC/ESWP2Gvj4AFxGv5jL6flAbPPGxPgBs=;
        b=sMc53I524bWziH5cK3CxcWoJ/YDLyYBDlwcoTg6nVNU0T4alpKPb8eA50djvYa/ic8
         7DJTD4MmU6XtoRIP8TgBHi9QCLZvybmo8ym9DFYYe3jdL7AaoCJm/917IISCuCtDDhoD
         lRaTHr9tcIz6bLjqOlhunAymSP/mOpOwJLkEZnIQAblQN1of3D6lF8Gc1ggLunnNvd5z
         Ze0zLDH+oGI0hfe5Slw2e3/Nbpj1Hw5fwS+gQPEAkJXfAiJ7sS3X4S/CwTqaYsytcF1F
         MMoxcfXpKb/QOk7zIGD0dvmibfwnYEbv3jm+uDE0DOML2gGQwgA6dlssUHzoTo6g7qXa
         bpuw==
X-Gm-Message-State: AOAM530EQxFJ4WO/PEm1QyapKVRzK8TNgCkiZQSgr03Conlr7MG0L6zW
        zazM8rPzQXg8UUrHihYqACYshQ==
X-Google-Smtp-Source: ABdhPJzYl2i9djyB85mC4XSa8URKw2iEGGxnQ5DBeKjmiQT4KYj06KTCr2IK69IPVAUYf4H5Dk8NTg==
X-Received: by 2002:a50:9991:: with SMTP id m17mr11593464edb.48.1607166613960;
        Sat, 05 Dec 2020 03:10:13 -0800 (PST)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id d4sm5520008edq.36.2020.12.05.03.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 03:10:13 -0800 (PST)
Subject: Re:
To:     Yury Norov <yury.norov@gmail.com>, Yun Levi <ppbuk5246@gmail.com>
Cc:     dushistov@mail.ru, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
 <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
 <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
 <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
 <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk>
 <CAM7-yPQrvYUwX-cbgpzhomCTFEi9sQ9iGuLNcL-Fsj7XZ0knhw@mail.gmail.com>
 <CAAH8bW9=J_now4SU=-WzvBOa=ftStgGVpspyw_g7oafbuNHNHQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <65bcccd3-db04-8056-e57c-0976a1eccfd5@rasmusvillemoes.dk>
Date:   Sat, 5 Dec 2020 12:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAH8bW9=J_now4SU=-WzvBOa=ftStgGVpspyw_g7oafbuNHNHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/12/2020 19.46, Yury Norov wrote:

> I would prefer to avoid changing the find*bit() semantics. As for now,
> if any of find_*_bit()
> finds nothing, it returns the size of the bitmap it was passed.

Yeah, we should actually try to fix that, it causes bad code generation.
It's hard, because callers of course do that "if ret == size" check. But
it's really silly that something like find_first_bit needs to do that
"min(i*BPL + __ffs(word), size)" - the caller does a comparison anyway,
that comparison might as well be "ret >= size" rather than "ret ==
size", and then we could get rid of that branch (which min() necessarily
becomes) at the end of find_next_bit.

I haven't dug very deep into this, but I could also imagine the
arch-specific parts of this might become a little easier to do if the
semantics were just "if no such bit, return an indeterminate value >=
the size".

> Changing this for
> a single function would break the consistency, and may cause problems
> for those who
> rely on existing behaviour.

True. But I think it should be possible - I suppose most users are via
the iterator macros, which could all be updated at once. Changing ret ==
size to ret >= size will still work even if the implementations have not
been switched over, so it should be doable.

> 
> Passing non-positive size to find_*_bit() should produce undefined
> behaviour, because we cannot dereference a pointer to the bitmap in
> this case; this is most probably a sign of a problem on a caller side
> anyways.

No, the out-of-line bitmap functions should all handle the case of a
zero-size bitmap sensibly.

Is bitmap full? Yes (all the 0 bits are set).
Is bitmap empty? Yes, (none of the 0 bits are set).
Find the first bit set (returns 0, there's no such bit)

Etc. The static inlines for small_const_nbits do assume that the pointer
can be dereferenced, which is why small_const_nbits was updated to mean
1<=bits<=BITS_PER_LONG rather than just bits<=BITS_PER_LONG.

Rasmus
