Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2461A270C4C
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgISJuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISJuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 05:50:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A7C0613CE;
        Sat, 19 Sep 2020 02:50:02 -0700 (PDT)
Message-Id: <20200919091751.011116649@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600509000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wXMSkZdDTGr2cnZMoKDSJw7MNirhJVzX4vOCHJbvoN0=;
        b=ul0AzmKXYj0qCi93y+r/rwwgxSXPin2sTe3PYhi7zjaY3NKa41EvWRmaZkAKju2f4qLfIs
        i1aVPwNRkUKTlsYfZfyyB/zi5KZf7ZY7OD58PCvZV59UcRuCOhEQsNPck5r1VuTJtHi72C
        +LNe+RY18cKtN3h7SPt+666fUzU5ch+DkMG/6qPFHiUag3Vd24Fa5TJBueGpK9wLzW3bo0
        IscYJhM/dQECgU1ilCEI7V6IMnuxdAonST0geBGtFlUWgd5xXJJx546wfo5abrk+4cO8Sx
        euhWyLJDvleHSJCh+QF6n/GwOhvNr9+hHKu+6tM3Z9VRQSgIOxJikgFGusnWsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600509000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wXMSkZdDTGr2cnZMoKDSJw7MNirhJVzX4vOCHJbvoN0=;
        b=KbJ6GiNRGpCyvVdElEw4H+4LtrSHxOXy5YeKjcqGSrhkBp5nKWiHepRirVJ50oI9WjzN2D
        1DCAFhaD9E835KBw==
Date:   Sat, 19 Sep 2020 11:17:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rmlyc3Qgb2YgYWxsLCBzb3JyeSBmb3IgdGhlIGhvcnJpYmx5IGJpZyBDYyBsaXN0IQoKRm9sbG93
aW5nIHVwIHRvIHRoZSBkaXNjdXNzaW9uIGluOgoKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjAwOTE0MjA0MjA5LjI1NjI2NjA5M0BsaW51dHJvbml4LmRlCgp0aGlzIHByb3ZpZGVzIGEg
cHJlZW1wdGlibGUgdmFyaWFudCBvZiBrbWFwX2F0b21pYyAmIHJlbGF0ZWQKaW50ZXJmYWNlcy4g
VGhpcyBpcyBhY2hpZXZlZCBieToKCiAtIENvbnNvbGlkYXRpbmcgYWxsIGttYXAgYXRvbWljIGlt
cGxlbWVudGF0aW9ucyBpbiBnZW5lcmljIGNvZGUKCiAtIFN3aXRjaGluZyBmcm9tIHBlciBDUFUg
c3RvcmFnZSBvZiB0aGUga21hcCBpbmRleCB0byBhIHBlciB0YXNrIHN0b3JhZ2UKCiAtIEFkZGlu
ZyBhIHB0ZXZhbCBhcnJheSB0byB0aGUgcGVyIHRhc2sgc3RvcmFnZSB3aGljaCBjb250YWlucyB0
aGUgcHRldmFscwogICBvZiB0aGUgY3VycmVudGx5IGFjdGl2ZSB0ZW1wb3Jhcnkga21hcHMKCiAt
IEFkZGluZyBjb250ZXh0IHN3aXRjaCBjb2RlIHdoaWNoIGNoZWNrcyB3aGV0aGVyIHRoZSBvdXRn
b2luZyBvciB0aGUKICAgaW5jb21pbmcgdGFzayBoYXMgYWN0aXZlIHRlbXBvcmFyeSBrbWFwcy4g
SWYgc28sIHRoZSBvdXRnb2luZyB0YXNrJ3MKICAga21hcHMgYXJlIHJlbW92ZWQgYW5kIHRoZSBp
bmNvbWluZyB0YXNrJ3Mga21hcHMgYXJlIHJlc3RvcmVkLgoKIC0gQWRkaW5nIG5ldyBpbnRlcmZh
Y2VzIGtbdW5dbWFwX3RlbXBvcmFyeSooKSB3aGljaCBhcmUgbm90IGRpc2FibGluZwogICBwcmVl
bXB0aW9uIGFuZCBjYW4gYmUgY2FsbGVkIGZyb20gYW55IGNvbnRleHQgKGV4Y2VwdCBOTUkpLgoK
ICAgQ29udHJhcnkgdG8ga21hcCgpIHdoaWNoIHByb3ZpZGVzIHByZWVtcHRpYmxlIGFuZCAicGVy
c2lzdGFudCIgbWFwcGluZ3MsCiAgIHRoZXNlIGludGVyZmFjZXMgYXJlIG1lYW50IHRvIHJlcGxh
Y2UgdGhlIHRlbXBvcmFyeSBtYXBwaW5ncyBwcm92aWRlZCBieQogICBrbWFwX2F0b21pYyooKSB0
b2RheS4KClRoaXMgYWxsb3dzIHRvIGdldCByaWQgb2YgY29uZGl0aW9uYWwgbWFwcGluZyBjaG9p
Y2VzIGFuZCBhbGxvd3MgdG8gaGF2ZQpwcmVlbXB0aWJsZSBzaG9ydCB0ZXJtIG1hcHBpbmdzIG9u
IDY0Yml0IHdoaWNoIGFyZSB0b2RheSBlbmZvcmNlZCB0byBiZQpub24tcHJlZW1wdGlibGUgZHVl
IHRvIHRoZSBoaWdobWVtIGNvbnN0cmFpbnRzLiBJdCBjbGVhcmx5IHB1dHMgb3ZlcmhlYWQgb24K
dGhlIGhpZ2htZW0gdXNlcnMsIGJ1dCBoaWdobWVtIGlzIHNsb3cgYW55d2F5LgoKVGhpcyBpcyBu
b3QgYSB3aG9sZXNhbGUgY29udmVyc2lvbiB3aGljaCBtYWtlcyBrbWFwX2F0b21pYyBtYWdpY2Fs
bHkKcHJlZW1wdGlibGUgYmVjYXVzZSB0aGVyZSBtaWdodCBiZSB1c2FnZSBzaXRlcyB3aGljaCBy
ZWx5IG9uIHRoZSBpbXBsaWNpdApwcmVlbXB0IGRpc2FibGUuIFNvIHRoaXMgbmVlZHMgdG8gYmUg
ZG9uZSBvbiBhIGNhc2UgYnkgY2FzZSBiYXNpcyBhbmQgdGhlCmNhbGwgc2l0ZXMgY29udmVydGVk
IHRvIGttYXBfdGVtcG9yYXJ5LgoKTm90ZSwgdGhhdCB0aGlzIGlzIG9ubHkgbGlnaHRseSB0ZXN0
ZWQgb24gWDg2IGFuZCBjb21wbGV0ZWx5IHVudGVzdGVkIG9uCmFsbCBvdGhlciBhcmNoaXRlY3R1
cmVzLgoKVGhlIGxvdCBpcyBhbHNvIGF2YWlsYWJsZSBmcm9tCgogICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgaGlnaG1lbQoKVGhh
bmtzLAoKCXRnbHgKLS0tCiBhL2FyY2gvYXJtL21tL2hpZ2htZW0uYyAgICAgICAgICAgICAgIHwg
IDEyMSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGEvYXJjaC9taWNyb2JsYXplL21tL2hpZ2htZW0u
YyAgICAgICAgfCAgIDc4IC0tLS0tLS0tLS0tLS0KIGEvYXJjaC9uZHMzMi9tbS9oaWdobWVtLmMg
ICAgICAgICAgICAgfCAgIDQ4IC0tLS0tLS0tCiBhL2FyY2gvcG93ZXJwYy9tbS9oaWdobWVtLmMg
ICAgICAgICAgIHwgICA2NyAtLS0tLS0tLS0tLQogYS9hcmNoL3NwYXJjL21tL2hpZ2htZW0uYyAg
ICAgICAgICAgICB8ICAxMTUgLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGFyY2gvYXJjL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9hcmMvaW5jbHVkZS9hc20vaGlnaG1l
bS5oICAgICAgICB8ICAgIDggKwogYXJjaC9hcmMvbW0vaGlnaG1lbS5jICAgICAgICAgICAgICAg
ICB8ICAgNDQgLS0tLS0tLQogYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDEgCiBhcmNoL2FybS9pbmNsdWRlL2FzbS9oaWdobWVtLmggICAgICAgIHwgICAzMCArKyst
LQogYXJjaC9hcm0vbW0vTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBhcmNoL2Nz
a3kvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgICAgMSAKIGFyY2gvY3NreS9pbmNsdWRl
L2FzbS9oaWdobWVtLmggICAgICAgfCAgICA0IAogYXJjaC9jc2t5L21tL2hpZ2htZW0uYyAgICAg
ICAgICAgICAgICB8ICAgNzUgLS0tLS0tLS0tLS0tLQogYXJjaC9taWNyb2JsYXplL0tjb25maWcg
ICAgICAgICAgICAgICB8ICAgIDEgCiBhcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vaGlnaG1l
bS5oIHwgICAgNiAtCiBhcmNoL21pY3JvYmxhemUvbW0vTWFrZWZpbGUgICAgICAgICAgIHwgICAg
MSAKIGFyY2gvbWljcm9ibGF6ZS9tbS9pbml0LmMgICAgICAgICAgICAgfCAgICA2IC0KIGFyY2gv
bWlwcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9taXBzL2luY2x1
ZGUvYXNtL2hpZ2htZW0uaCAgICAgICB8ICAgIDQgCiBhcmNoL21pcHMvbW0vaGlnaG1lbS5jICAg
ICAgICAgICAgICAgIHwgICA3NyAtLS0tLS0tLS0tLS0tCiBhcmNoL21pcHMvbW0vaW5pdC5jICAg
ICAgICAgICAgICAgICAgIHwgICAgMyAKIGFyY2gvbmRzMzIvS2NvbmZpZy5jcHUgICAgICAgICAg
ICAgICAgfCAgICAxIAogYXJjaC9uZHMzMi9pbmNsdWRlL2FzbS9oaWdobWVtLmggICAgICB8ICAg
MjEgKystCiBhcmNoL25kczMyL21tL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAgMSAKIGFy
Y2gvcG93ZXJwYy9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL2hpZ2htZW0uaCAgICB8ICAgIDYgLQogYXJjaC9wb3dlcnBjL21tL01ha2Vm
aWxlICAgICAgICAgICAgICB8ICAgIDEgCiBhcmNoL3Bvd2VycGMvbW0vbWVtLmMgICAgICAgICAg
ICAgICAgIHwgICAgNyAtCiBhcmNoL3NwYXJjL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwg
ICAgMSAKIGFyY2gvc3BhcmMvaW5jbHVkZS9hc20vaGlnaG1lbS5oICAgICAgfCAgICA3IC0KIGFy
Y2gvc3BhcmMvbW0vTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgICAzIAogYXJjaC9zcGFyYy9t
bS9zcm1tdS5jICAgICAgICAgICAgICAgICB8ICAgIDIgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9m
aXhtYXAuaCAgICAgICAgIHwgICAgMSAKIGFyY2gveDg2L2luY2x1ZGUvYXNtL2hpZ2htZW0uaCAg
ICAgICAgfCAgIDEyICstCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pb21hcC5oICAgICAgICAgIHwg
ICAyOSArKystLQogYXJjaC94ODYvbW0vaGlnaG1lbV8zMi5jICAgICAgICAgICAgICB8ICAgNTkg
LS0tLS0tLS0tLQogYXJjaC94ODYvbW0vaW5pdF8zMi5jICAgICAgICAgICAgICAgICB8ICAgMTUg
LS0KIGFyY2gveDg2L21tL2lvbWFwXzMyLmMgICAgICAgICAgICAgICAgfCAgIDU3IC0tLS0tLS0t
LS0KIGFyY2gveHRlbnNhL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC94
dGVuc2EvaW5jbHVkZS9hc20vaGlnaG1lbS5oICAgICB8ICAgIDkgKwogYXJjaC94dGVuc2EvbW0v
aGlnaG1lbS5jICAgICAgICAgICAgICB8ICAgNDQgLS0tLS0tLQogYi9hcmNoL3g4Ni9LY29uZmln
ICAgICAgICAgICAgICAgICAgICB8ICAgIDMgCiBpbmNsdWRlL2xpbnV4L2hpZ2htZW0uaCAgICAg
ICAgICAgICAgIHwgIDE0MSArKysrKysrKysrKysrKystLS0tLS0tLS0KIGluY2x1ZGUvbGludXgv
aW8tbWFwcGluZy5oICAgICAgICAgICAgfCAgICAyIAogaW5jbHVkZS9saW51eC9zY2hlZC5oICAg
ICAgICAgICAgICAgICB8ICAgIDkgKwoga2VybmVsL3NjaGVkL2NvcmUuYyAgICAgICAgICAgICAg
ICAgICB8ICAgMTAgKwogbW0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
IDMgCiBtbS9oaWdobWVtLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE5MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tCiA0OSBmaWxlcyBjaGFuZ2VkLCA0MjIgaW5zZXJ0
aW9ucygrKSwgOTA5IGRlbGV0aW9ucygtKQo=
