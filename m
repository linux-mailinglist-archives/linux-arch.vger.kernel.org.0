Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904CF439958
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhJYO5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhJYO5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 10:57:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE07C061745;
        Mon, 25 Oct 2021 07:55:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id v17so10549751qtp.1;
        Mon, 25 Oct 2021 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lhcq3mtoqVS+aHWU0W9BXR1xARM/S8unL7B46ETl5A=;
        b=eubAxmKNf0HGfyvCVJaJcBGu3LC/0zm6EM5SL47XSI+2kMoZ5hYfDNgv5xKK7/llki
         CWYHSNa2kva472UlnrI1JLjqNvBQlbr42lpepor2zK3LX1ewz8rL1nchV6oq+gJKM6qz
         8BijkyhohWnD5Dwj2rfTXBQwAC1+Uj2prtXaPD4aJFmIaJdvbAAdhx9jDeiOn1L1/tJh
         axHQvPqiNOeJwY75NqdDV+SsOagS5GOPnaO3Ro4O6RRLtiHGapmEoiMLtuCYEq+E6kW9
         1tDztmMMF3Xn6Pyj2wqibMtVGwNFAswwUcIQLPRhVsSawGrjWSjhRf2WbfwaJ2qVXt+0
         z+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lhcq3mtoqVS+aHWU0W9BXR1xARM/S8unL7B46ETl5A=;
        b=VBwLaxYAwjD7nEu3rSVbktHiFOqaY8Go1i3cL60Mu86zElBaj3n8Yac6xHxRH/JJcT
         XGxHWpPM4JM+JPfmzWp/C7pXOBFmz+KQZ1EgGBlqENfK/ksWaqgghkYD22yBDCbcUV9Y
         kxjZ40o8Z4Xr0sJ2f2iLFHeW8RlQTZiI3yTQWp4JM2BRdfykyJ+6V4nCoMtIhlOoHLw5
         zVOyLWuUDrZHmc0xebtlVLxN1rU+tlmoVhri67pzKbC5uNcMlxHsbc/f6B6w4QG38rRh
         PhrWcA4mQz4qt+6bskleryysNeeSmQf7AYN5BFXZWYhgJZSst/qAR0CmafGLn6caCArN
         OKvw==
X-Gm-Message-State: AOAM531CfU8UmU5w9jKr1VD8cUXrEhzsiDQBiu2HvttJsyIDZRzq7Nf3
        /+iWqp0E19hsrh7HBd3R+sk=
X-Google-Smtp-Source: ABdhPJxuS5WBX79fRoguMv16c828fhnrk028h32D5bckw+tTO4RAOVfZcayqGjp0ks7eLCdmHgDCFg==
X-Received: by 2002:ac8:42dd:: with SMTP id g29mr18193067qtm.168.1635173700971;
        Mon, 25 Oct 2021 07:55:00 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n2sm9080420qtk.8.2021.10.25.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:55:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id A918A27C0054;
        Mon, 25 Oct 2021 10:54:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Oct 2021 10:54:58 -0400
X-ME-Sender: <xms:QMV2YY0gD-SzxpAds7Sh8V81jcseKzqFuuV-M-Gb6IrbwiIE4AOq7A>
    <xme:QMV2YTGmoUHxwZXYCBhrVhB8MbNgTuLvwK1Wk-AAUbn7VC0fiBtr7tjbJdG1F4deJ
    L8NtokQWE4X3URnkQ>
X-ME-Received: <xmr:QMV2YQ4hsNdiAb4cpJowHyztwvdgkGusXJ9So9Uk5Cbl8B4fChUY6OotZ9uqRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgggfestdek
    redtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgse
    hgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeiueevjeelheduteefveeflefg
    jeetfeehvdekudekgfegudeghfduhfetveejudenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:QMV2YR0TfPV50jKFn8AXvqcSBlObruKTsCE-BdzGx53h-qAQxyGrpw>
    <xmx:QMV2YbH1___Tf_EKXBrRrWb6KAP38rdByaiu8CRlGdT5H7CuH4UaXA>
    <xmx:QMV2Ya8-y3TA2J_4Fa7U1hVrcUb3FJzmyOyo_WmsedLStuTtSexDvg>
    <xmx:QsV2YWnxSB5CSBpAiD5fiJO33gpy5d8W689_meCWGxJhg_1aotp3grzgcEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 10:54:55 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 0/3] memory model: Make unlock(A)+lock(B) on the same CPU RCtso
Date:   Mon, 25 Oct 2021 22:54:13 +0800
Message-Id: <20211025145416.698183-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Just a new version trying to make forward progress on this  ;-)

v1: https://lore.kernel.org/lkml/20210930130823.2103688-1-boqun.feng@gmail.com/

Changes since v1:

*	Split the patch into three to help resolve the litmus test
	addition discussion.
*	Add some explanation in patch #2 on the requirement of tests in
	litmus-tests directory.

To summarize the change in memory model, we now guarantee in the
following code:

	<memory access M>
	spin_unlock(A);
	spin_lock(B);
	<memory access N>

M is ordered against N unless M is a store and N is a load. More
detailed examples of this guarantee can be found in patch #3.

Architecture maintainers, appreciate it that you can take a look at
patch #3 and rest of whole set to confirm this guarantee works on your
architectures.

Alan, I split the patchset into three patches because I do think we need
some sort of patch #2 so that we can have consensus about whether merge
patch #3 or not. I know you want to keep litmus-tests directory as
simple as possible, but it won't hurt to document the requirement.
Looking forwards to your thoughts ;-)

Suggestion and comments are welcome!

Regards,
Boqun


Boqun Feng (3):
  tools/memory-model: Provide extra ordering for unlock+lock pair on the
    same CPU
  tools/memory-model: doc: Describe the requirement of the litmus-tests
    directory
  tools/memory-model: litmus: Add two tests for unlock(A)+lock(B)
    ordering

 .../Documentation/explanation.txt             | 44 +++++++++++--------
 tools/memory-model/README                     | 12 +++++
 tools/memory-model/linux-kernel.cat           |  6 +--
 ...LB+unlocklockonceonce+poacquireonce.litmus | 33 ++++++++++++++
 ...unlocklockonceonce+fencermbonceonce.litmus | 33 ++++++++++++++
 tools/memory-model/litmus-tests/README        |  8 ++++
 6 files changed, 114 insertions(+), 22 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus

-- 
2.33.0

