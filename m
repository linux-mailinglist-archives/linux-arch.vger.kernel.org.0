Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96066E90DC
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 21:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJ2UhR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 16:37:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38751 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 16:37:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so15132201wrq.5
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRhnrmB+ijpIENLvNMWsjQXO/kOYcBONzviL0obRJs4=;
        b=C3M3/y+TLjza3wimeJs8rWciiXa7rodbQBbutdOXZ4IctymP0lddNtwy0FfkRLQV8i
         jJfta0vYJayfA2SejvZ+JRYtax+ltj47uFN11MTlMkbKiRvh6s2ycTgAPxmxB1ET+AUn
         s70mqMd96vtA5EUXDI2h6J24hL+W6jEhxLmZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRhnrmB+ijpIENLvNMWsjQXO/kOYcBONzviL0obRJs4=;
        b=kmMYVfVNFHjzC7mZS11SBWHxJkcXGeNta4R+g1kz1kbR321ZzndXPOyzB9tZn0BIf5
         QyHZDqLH/qP4ID17W06bMkNdiuBsZaonT00+Me7y3hHkNDTaculhfVHk3bsM+1VjMS4/
         PRugKzc1Q51tNFl8OlG4h1J36QKb26c0c8Pzz7fSnidvIHAneCBQr7FpGaWLhjB9A2aZ
         wEqq4/eMb7zxtZHo/1bAWRDKmF9OndOgIMts9HJfYILB3egRvSDsA72aDSidOmrmtK7q
         unD1reifoSHeSa84Nop45t04/V2xMI1VuS8xC2++nOQGO8E3gX80TieeSay6v1IB1tvd
         y6rg==
X-Gm-Message-State: APjAAAUcKkYWYL2WBw1pvg1AVKBgHvHdku7RXCBE1P4kZmzhJiBRi4JD
        D0XjbDjNN7ZkQARew93bxZ4g3WC3BSuFzUDw
X-Google-Smtp-Source: APXvYqyhQswqQqgTJESq7XubFPQxrrPAZjgc9H7Nt+m2PQZpI7MF2AzpUdj21gzzKwvdLpBK5/8YBg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr22359046wrq.129.1572381434716;
        Tue, 29 Oct 2019 13:37:14 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id 6sm5085121wmd.36.2019.10.29.13.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:37:14 -0700 (PDT)
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, Arnd Bergmann <arnd@arndb.de>,
        Jessica Yu <jeyu@kernel.org>, linux-arch@vger.kernel.org
References: <20191029200026.9790-1-jim.cromie@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e9835376-1efe-1d1b-4a99-8bb920e04a08@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 21:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029200026.9790-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 29/10/2019 21.00, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.

Yeah, that has always bugged me. Ack to that part.

> Also, per checkpatch:
>   move extern struct _ddebug __(start|stop)__dyndbg[] to header file

Hm, why? checkpatch should often be ignored. Since we only refer to
those symbols in the .c file, there's no reason to pollute every other
translation unit with those declarations. Having declarations in a
header makes sense when the actual entity gets defined in some .c file
(which hopefully also includes the header). But these are defined by the
linker, so there's no type safety to be had.

>   simplify __attribute(..) to __section(__dyndbg) declaration.

Makes sense, since you're munching the thing anyway.

Rasmus
