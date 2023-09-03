Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE2790F31
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjICX2K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 19:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICX2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 19:28:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D47CE;
        Sun,  3 Sep 2023 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QOimqPZwEG4DywTpNJH+D9QUy1Cy+YniSscgO3ZWNK4=; b=lK2EYOk++M1SNvBijQY1YAXniK
        v5/I3lIsBQptyQ+ncm80Pm5liAan9eKtGKgOjfYckS73KRMenZf/wbKppUGhI5YbyposFEReVEopS
        HtawQ7VcQd7EUUHNafBFmh1l72w46Wn0T0IoVz1yHue/+CfskFEJmSHGF1FWr2qaYIx8vlgfGwtoO
        raJ7Zmrr+7pfO8uhWML9YDvBVoCe/qxp3d6cVsOFaOmQqyVS2A3G0fERW/lq+SNCXNDdgDWJbNaxn
        1TBZ8+IRgIW01jJrYI6t7w4vNGt661Js14gAf7ymSYYbykTwAROur0PLHvSGiXdBdMbxuj2x0B4D4
        jawzRVhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qcwVe-003ArN-2K;
        Sun, 03 Sep 2023 23:28:02 +0000
Date:   Mon, 4 Sep 2023 00:28:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Message-ID: <20230903232802.GO3390869@ZenIV>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
 <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f>
 <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
 <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com>
 <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
 <CAGudoHHOEMvz6=JZ2XZYKgKTqQ-FeCcXxVEvS2xBncn-ck5JXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHOEMvz6=JZ2XZYKgKTqQ-FeCcXxVEvS2xBncn-ck5JXg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 03, 2023 at 11:18:44PM +0200, Mateusz Guzik wrote:
> On 9/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Sun, 3 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >>
> >> I don't think it is *that* bad. I did a quick sanity check on that
> >> front by rolling with bpftrace on cases which pass AT_EMPTY_PATH *and*
> >> provide a path.
> >
> > I guess you are right - nobody sane would use AT_EMPTY_PATH except if
> > they don't have a path.
> >
> > Of course, the only reason we're discussing this in the first place is
> > because people are doing insane things, which makes _that_ particular
> > argument very weak indeed...
> >
> 
> I put blame on whoever allowed non-NULL path and AT_EMPTY_PATH as a
> valid combination, forcing the user buf to be accessed no matter what.
> But I'm not going to go digging for names. ;)

ITYM s/allowed/mandated/ - AT_EMPTY_PATH with NULL is -EFAULT.
