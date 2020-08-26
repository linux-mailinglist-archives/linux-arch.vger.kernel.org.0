Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868CD2538F3
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZUMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 16:12:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgHZUMl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 16:12:41 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MbAUg-1kmITn0iK0-00bdw3; Wed, 26 Aug 2020 22:12:39 +0200
Received: by mail-qk1-f173.google.com with SMTP id u3so3440987qkd.9;
        Wed, 26 Aug 2020 13:12:38 -0700 (PDT)
X-Gm-Message-State: AOAM5317UekgUosnUoWFP7mlWCUCEydvVZR/6CF3e2uUkS/WnaEmGNwe
        dZsSjErWYegXVl4YL4rdNGdTTQ2rNAxShpK+f1s=
X-Google-Smtp-Source: ABdhPJxhc4alN5hdSxUDe7JMPS2m96WmDmutFJ3jt08/0N904t71Mio1+gRavVxjcvQwSOw7b+NsbxP4jRJgZhk8Yd0=
X-Received: by 2002:a37:8405:: with SMTP id g5mr15405358qkd.286.1598472757982;
 Wed, 26 Aug 2020 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145249.745432-1-npiggin@gmail.com>
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Aug 2020 22:12:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3MNKa3RhG6TUg59+yHvVEa3DLNyqpWSO1c_HLRLP_YRQ@mail.gmail.com>
Message-ID: <CAK8P3a3MNKa3RhG6TUg59+yHvVEa3DLNyqpWSO1c_HLRLP_YRQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] Use asm-generic for mmu_context no-op functions
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wT87E8wdVK6j8liRYR2q8D1pbfFNMWA4alW5k0Jpk8WL7UMFy9B
 9Vir2Vid0yZmedB8ASFUty3Swptv4umKmxND5+HMpST23Df5b9hD2j8BIkuqKsJQ9kVsqQ9
 DmlHXJMtuhZz5rYJwKWR59FKLrZmyiY6kZarwI+k6aSggU7gS9Vckz1uQg6YoC5bTY4EUWs
 F4Zk00AEEzw4aARKwX1oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DS3C4dfbomA=:tYDr0mMAZbefkq/N+ocGKj
 8iQmmEYU+SnMbiG3V0uuBcQgcMv7vkEd0+XmLdwBShtVrDX7sVEaX9dScXcR2NjtxESyUQW13
 FS26BrtsSMJ7DLfyK/jVcrlgol0z1Eiwl0/6UxWbtMoM1zMH1ZyUovLFCUZrwoX2RNws+QG+7
 9iFl4Sj5AXyfWl75Tk6WiK1lnyI7b3yDEBn37g+IhT2i13EJQl2TAmAsPwy7l3nsZ/PE0Tlh/
 MmN38prxW3VYO32SsmBztCXLRQU41qw1lTpNUGmUmQwc9XxaiWC2gVbJwna3qoT8+IQxIM5ra
 Cx6WBzvhLTB7bFUJe4mnpB5yOhx8fBTWea4RSxeBpjNbLlQWycWRzW2o/D//95/Oyb+P+RWJb
 QBBvn6jb4s5TUK7EWY8FVkRgWTkziC15V3M4gVLPf9P5ExuKHzrtQBaW8pg2VVYHHShpdf0nx
 Hi0XmWYzb9I+es0N2DPU6rnKUK1VJSXoSraee1nNH5xJc9RxV1V5uLC8VJdvE4fXj/SfidxIU
 ZPmpq8OcBFbapK0PbAe+M8isSRE5u30g4H8/DaEhFtmqnmAOuufwe8FJ0OSniP8bgR3gwO3Fl
 rrB7YIhM19Aw4Oc4anwxDQ3BHVAXW1H2b+SJfrHwoOROpnBHUnDNjW0p/zyP4hucZV0FKuWto
 YFid3g5ICrZp9ZZSleaf/U993K/TU0iH4Vvtb7YInU0J8l4ScRanZTSP8ApwA7U5fI3860HnG
 gfM02JNodHu79CY3c3lXRxvcC45Fj7bhg65Ta1fyau1cw9SJPwGZAVwVO/ItccyYGjKJR4sm5
 UaSYUnu4G+DpHuBJNw7J6AzcLYlumtXof3GmSyde4RmFUNng66Dcbo6c+kDcto7bY+2IKzG
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 4:53 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> It would be nice to be able to modify mmu_context functions or add a
> hook without updating all architectures, many of which will be no-ops.
>
> The motivation for this series is a change to lazy mmu handling, but
> this series stands on its own as a good cleanup whether or not we end
> up making that change.
>
> Arnd, is this something you could take through your asm-generic tree?
> (assuming arch maintainers are okay with it)

Yes, I can definitely take this. The patches all look good to me, so
feel free to add "Acked-by: Arnd Bergmann <arnd@arndb.de" if you
like (not really needed if I merge them later though) and send me a
pull request once you feel you have collected enough Ack from others.

     Arnd
