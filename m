Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A275124D2E8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHUKjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgHUKjq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 06:39:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AFEC061385;
        Fri, 21 Aug 2020 03:39:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s14so701638plp.4;
        Fri, 21 Aug 2020 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Skacs7EXPHqa2+iszJrJANOJ0qE5l/8OmxgUeJzvuFY=;
        b=ZfZ2d783cAo/vy9wrAfQVsV1+q70NFpvLIJ3BoYZINr9O786s+tQmwNqHeMpm5O7zn
         OeHng3P+2eSSdKHvQGdxM7DrC0azCxER5jh3PrvGpqN7Y23q1rOPKa4kl+cS+exGEQ+Z
         rneOhz224LM3Js++bPwmJxjiWKyl/+mUR0QxcWkYT53uwjOJQPi76kdkmmmfql4q2yMY
         5YUESktvVqAOCKRFnyPxqZGjYlLBfiOpHGto3CNlAoCjHAG/xfT8PjUzoNr4Ksmu9UB0
         xGlraVIm+bqntt9AYH09O9yJ7x/D67O5a06kMj6rouCJlv6ZT6YIlINaq/EDTR8J0FN5
         /kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Skacs7EXPHqa2+iszJrJANOJ0qE5l/8OmxgUeJzvuFY=;
        b=BYBmRaOH4NRfP1Gj1W76YjBMZ5GETa7md5Put1E8sf+GVNnmA98c8m+2c6TK/G7RmL
         XdEbYzoo6KmNjSXbBZoKE7Sh8JUZL+/JUo2KjqksxuiVcu7TrmytDfUalM1Gk4i2j95E
         JDEztAm2ldXFID1l68WVKEGnUmC8lxgF4am4d+hbOR8y8mOW/T9TB5mc974+2otOJSLT
         U5RW2HVxUkxHWooASmiQfqrRkLCBzIsGf8p5+9PIbW3CcfeXKF3loEPwQSq3XYFcw3fF
         kaXy/oFHwoLZgpaYJ9ZnUTH27qjxrhcVE2S4E2fTBmCEe8A4icOTUDfoCCD4GHXxUNFu
         UW6w==
X-Gm-Message-State: AOAM531dNUAyCMkZNvdU9g2zgePp1SJi9AMffj+5+121PTpRz1Sg0BfF
        CoZESmU3SPLZ5QtRR1ByOiU=
X-Google-Smtp-Source: ABdhPJzIJef66nd1vfnY7XWT91zvftzIW9FTEQh30rfVNzjQ0tbfwAFB3N+KRw14E+4Hqn6/KGT2Yw==
X-Received: by 2002:a17:90a:fa92:: with SMTP id cu18mr1837292pjb.215.1598006385206;
        Fri, 21 Aug 2020 03:39:45 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id 193sm2120352pfu.169.2020.08.21.03.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:39:44 -0700 (PDT)
Date:   Fri, 21 Aug 2020 20:39:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 5/8] mm: HUGE_VMAP arch support cleanup
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
        <20200821044427.736424-6-npiggin@gmail.com>
        <9b67b892-9482-15dc-0c1e-c5d5a93a3c91@csgroup.eu>
In-Reply-To: <9b67b892-9482-15dc-0c1e-c5d5a93a3c91@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1598006254.vcbwyiiw9l.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of August 21, 2020 3:40 pm:
>=20
>=20
> Le 21/08/2020 =C3=A0 06:44, Nicholas Piggin a =C3=A9crit=C2=A0:
>> This changes the awkward approach where architectures provide init
>> functions to determine which levels they can provide large mappings for,
>> to one where the arch is queried for each call.
>>=20
>> This removes code and indirection, and allows constant-folding of dead
>> code for unsupported levels.
>=20
> I think that in order to allow constant-folding of dead code for=20
> unsupported levels, you must define arch_vmap_xxx_supported() as static=20
> inline in a .h
>=20
> If you have them in .c files, you'll get calls to tiny functions that=20
> will always return false, but will still be called and dead code won't=20
> be eliminated. And performance wise, that's probably not optimal either.

Yeah that's true actually, I think I didn't find a good place to add
the prototypes in the arch code but I'll have another look and either
rewrite the changelog or remove it. Although this does get a step closer
at least.

Thanks,
Nick
