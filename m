Return-Path: <linux-arch+bounces-7688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C5990146
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 12:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FC6280E78
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275F3156227;
	Fri,  4 Oct 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RTdh+l+l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605415535B
	for <linux-arch@vger.kernel.org>; Fri,  4 Oct 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037804; cv=none; b=YTkJPCs+tTTc9+tVsmik91//3DZHywtaih3PaAGI/XrlZxf5MaXWN+yrT1vHPdlSI2+g03LoOPLdmwi7Adv9u1DQypviQ1v0Zeb0sHQQO5Crj1wU/LWeh9d8x9cVODNy+2GdeIvmymInbTlhy9SgyuN3pynfS6XlSWdZdJ1xoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037804; c=relaxed/simple;
	bh=RIvcj1BuUFiQT751u6HK5TYEXq6OzEX2R/3bDQCqZyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqHSEz/NrXWuWlM8i2dldn/IFpda+/OhLsRyJumrw8eYfedRHNQrVpNCaHhIxF2DeYGPR00iAWqPShzKNb2t3d6zJJk8pMQAQgMNTyOHwnWRJ3u0Gabay3vLZOB5+QcL8VIruEaA0AlpBxONRbkk/SwAf4Hrf02ZgzLbRmz5COQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RTdh+l+l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccd81de57so1201852f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 04 Oct 2024 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728037799; x=1728642599; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RIvcj1BuUFiQT751u6HK5TYEXq6OzEX2R/3bDQCqZyY=;
        b=RTdh+l+ldwvOWRi/1zZhyv5S+3lux541qMonp03+eRiFFdGrZHZuxWLp1mUzs273LJ
         h72n4N20arND8utnU4okbp6RG3N0yfT8Q4GDFfHvzUani4cMo8OMHgnOcnZOCCC++DOM
         s5Fp8OuiJMQL9/Jhx5SQX+ap8EOLUbiTCwKKjbEHE9zTomX2SHahyF/ILKLym4hIMAGS
         1iq52gi000TY95qRWc0xsWnluG1foHRU02+T3j4aR4evUXJybk0Uz45hI7fbyddPjlrX
         ZffPBTWlSLw+Fw6MD0VtZ0/EJ0bu7o7nz7ePJeCD0CazxOsB/yEAfSZ2KH2qwer+c9NB
         psNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037799; x=1728642599;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIvcj1BuUFiQT751u6HK5TYEXq6OzEX2R/3bDQCqZyY=;
        b=wky+bACV6XxM90rdR63gc9aFIqOT6OPqtmcinUlJyb21EXYfVZX+WJahfcFch9CwsB
         peG5g9RntChhEH4oao9b+2vCq3NITWD/W8r14ZcD25Bx/ubXuQkamvQYOyPF9xsB432j
         xFC565G0pjE06akd7WUNfpBFVgfEC6x0OGB0pee13kjyhrkHijREP3ZjEzDP0cpNf1mv
         pEpy/AV30GIBkL8yTHLEVxUbaxDvwrWoQNlbW7ew9HPH2+R7f1wdAI4xNlIK+PI4iKOX
         sYO3qu6drGoasDyUbczlDsQ2qy/6XUCnvvLkJeHEKY8T+nELDVroWjRjSEzjIXsCOD4b
         PUqw==
X-Forwarded-Encrypted: i=1; AJvYcCVzNYsVKhv4bcHQEgWY6R0NuIiVqPhZS7/u0dFb6+7cR3RX4pLz9mmOvu67mWVeLQJ7c+bHQTthdpEA@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxDuSSTYA2ccLTAFOqHbLKFDNNd1dELwY9nAkHTt28JB3dODu
	zCjWTxJVA55rh8x4aBYxgmSorPfEgEauLBWeBPbXoGlcAyDvVG/fExMTTr1C6rU=
X-Google-Smtp-Source: AGHT+IF6hBfqegIvF+42BBg98CfZX7oY4dEhFkTdD0uWULyjepJ1sGnxEOlgat0MyUOb2/Gwwvw6sg==
X-Received: by 2002:a05:6000:c86:b0:37c:ca20:52a with SMTP id ffacd0b85a97d-37d0f6a15cemr1609070f8f.8.1728037798579;
        Fri, 04 Oct 2024 03:29:58 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0826240csm2954673f8f.65.2024.10.04.03.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 03:29:58 -0700 (PDT)
Message-ID: <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
Date: Fri, 4 Oct 2024 12:29:57 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
To: x86@kernel.org, Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <2210883.Icojqenx9y@gongov> <878qv8ypkl.ffs@tglx>
 <864022534.0ifERbkFSE@gongov>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <864022534.0ifERbkFSE@gongov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n72mePX18IlQNf7LHvphnPEC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------n72mePX18IlQNf7LHvphnPEC
Content-Type: multipart/mixed; boundary="------------oGNco0rjlCNeTnFT07O0xQiy";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: x86@kernel.org, Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <45f3a10c-8695-42cb-abb8-8c13ce1a476b@suse.com>
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
References: <2210883.Icojqenx9y@gongov> <878qv8ypkl.ffs@tglx>
 <864022534.0ifERbkFSE@gongov>
In-Reply-To: <864022534.0ifERbkFSE@gongov>

--------------oGNco0rjlCNeTnFT07O0xQiy
Content-Type: multipart/mixed; boundary="------------I0x1JdOzcn4coEfmwNUWyFma"

--------------I0x1JdOzcn4coEfmwNUWyFma
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMTAuMjQgMTI6MDUsIE5pZWxzIERldHRlbmJhY2ggd3JvdGU6DQo+IFZpcnR1YWwg
bWFjaGluZXMgdW5kZXIgWGVuIEh5cGVydmlzb3IgKERvbVUpIHJ1bm5pbmcgaW4gWGVuIFBW
IG1vZGUgdXNlIGENCj4gc3BlY2lhbCwgbm9uc3RhbmRhcmQgc3ludGhldGl6ZWQgQ1BVIHRv
cG9sb2d5IHdoaWNoICJqdXN0IHdvcmtzIiB1bmRlcg0KPiBrZXJuZWxzIDYuOS54IHdoaWxl
IG5ld2VyIGtlcm5lbHMgd3JvbmdseSBhc3N1bWluZyBhICJjcmFzaCBrZXJuZWwiIGFuZA0K
PiBkaXNhYmxlIFNNUCAocmVkdWNpbmcgdG8gb25lIENQVSBjb3JlKSBiZWNhdXNlIHRoZSBu
ZXdlciB0b3BvbG9neQ0KPiBpbXBsZW1lbnRhdGlvbiBwcm9kdWNlcyBhIHdyb25nIGVycm9y
ICJbRmlybXdhcmUgQnVnXTogQVBJQyBlbnVtZXJhdGlvbg0KPiBvcmRlciBub3Qgc3BlY2lm
aWNhdGlvbiBjb21wbGlhbnQiIGFmdGVyIG5ldyB0b3BvbG9neSBjaGVja3Mgd2hpY2ggYXJl
DQo+IGltcHJvcGVyIGZvciBYZW4gUFYgcGxhdGZvcm0uIEFzIGEgcmVzdWx0LCB0aGUga2Vy
bmVsIGRpc2FibGVzIFNNUCBhbmQNCj4gYWN0aXZhdGVzIGp1c3Qgb25lIENQVSBjb3JlIHdp
dGhpbiB0aGUgUFYgRG9tVSAiVk0iIChEb21VIGluIFBWIG1vZGUpLg0KPiANCj4gVGhlIHBh
dGNoIGRpc2FibGVzIHRoZSByZWdhcmRpbmcgY2hlY2tzIGlmIGl0IGlzIHJ1bm5pbmcgaW4g
WGVuIFBWDQo+IG1vZGUgKG9ubHkpIGFuZCBicmluZyBiYWNrIFNNUCAvIGFsbCBDUFVzIGFz
IGluIHRoZSBwYXN0IHRvIHN1Y2ggRG9tVQ0KPiBWTXMuIFRoZSBYZW4gc3Vic3lzdGVtIHRh
a2VzIGNhcmUgb2YgdGhlIHByb3BlciBpbnRlcmFjdGlvbiBiZXR3ZWVuICJndWVzdCINCj4g
KERvbVUpIGFuZCB0aGUgImhvc3QiIChEb20wKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5p
ZWxzIERldHRlbmJhY2ggPG5kQHN5bmRpY2F0LmNvbT4NCg0KRG9lcyB0aGUgYXR0YWNoZWQg
cGF0Y2ggaW5zdGVhZCBvZiB5b3VycyBoZWxwPw0KDQpDb21waWxlIHRlc3RlZCBvbmx5Lg0K
DQoNCkp1ZXJnZW4NCg0K
--------------I0x1JdOzcn4coEfmwNUWyFma
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-xen-mark-boot-CPU-of-PV-guest-in-MSR_IA32_APICBA.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-xen-mark-boot-CPU-of-PV-guest-in-MSR_IA32_APICBA.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyZDQ4ZmI5ZGRjYTBhYTY1MTBmNGYxODk2NjExMjIyMmQ0MDVhZWRjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IEZyaSwgNCBPY3QgMjAyNCAxMjoyMjoxMiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IHg4Ni94ZW46IG1hcmsgYm9vdCBDUFUgb2YgUFYgZ3Vlc3QgaW4gTVNSX0lBMzJfQVBJQ0JB
U0UKClJlY2VudCB0b3BvbG9neSBjaGVja3Mgb2YgdGhlIHg4NiBib290IGNvZGUgdW5jb3Zl
cmVkIHRoZSBuZWVkIGZvcgpQViBndWVzdHMgdG8gaGF2ZSB0aGUgYm9vdCBjcHUgbWFya2Vk
IGluIHRoZSBBUElDQkFTRSBNU1IuCgpGaXhlczogOWQyMmM5NjMxNmFjICgieDg2L3RvcG9s
b2d5OiBIYW5kbGUgYm9ndXMgQUNQSSB0YWJsZXMgY29ycmVjdGx5IikKUmVwb3J0ZWQtYnk6
IE5pZWxzIERldHRlbmJhY2ggPG5kQHN5bmRpY2F0LmNvbT4KU2lnbmVkLW9mZi1ieTogSnVl
cmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgotLS0KIGFyY2gveDg2L3hlbi9lbmxpZ2h0
ZW5fcHYuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYyBiL2FyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHYuYwppbmRleCAyYzEyYWU0MmRjOGIuLmQ2ODE4YzZjYWZkYSAxMDA2NDQK
LS0tIGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jCisrKyBiL2FyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHYuYwpAQCAtMTAzMiw2ICsxMDMyLDEwIEBAIHN0YXRpYyB1NjQgeGVuX2Rv
X3JlYWRfbXNyKHVuc2lnbmVkIGludCBtc3IsIGludCAqZXJyKQogCXN3aXRjaCAobXNyKSB7
CiAJY2FzZSBNU1JfSUEzMl9BUElDQkFTRToKIAkJdmFsICY9IH5YMkFQSUNfRU5BQkxFOwor
CQlpZiAoc21wX3Byb2Nlc3Nvcl9pZCgpID09IDApCisJCQl2YWwgfD0gTVNSX0lBMzJfQVBJ
Q0JBU0VfQlNQOworCQllbHNlCisJCQl2YWwgJj0gfk1TUl9JQTMyX0FQSUNCQVNFX0JTUDsK
IAkJYnJlYWs7CiAJfQogCXJldHVybiB2YWw7Ci0tIAoyLjQzLjAKCg==
--------------I0x1JdOzcn4coEfmwNUWyFma
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------I0x1JdOzcn4coEfmwNUWyFma--

--------------oGNco0rjlCNeTnFT07O0xQiy--

--------------n72mePX18IlQNf7LHvphnPEC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmb/w6UFAwAAAAAACgkQsN6d1ii/Ey+C
8Af9HJglV0H0bNF7waKrFeVz7xYCI9tsK36B4SJ/AYr1Tf04Jym7ccUe9EjfkgUOyONwRHwA9VyH
kt+6FyoDASrFqFFhqhaonz+GNA8Q5ukWCintfvYf2G66lUxET9+LjWf7BQqAOLJB9BcJmnOcY/0n
27qxuJQ2VtriDwl3Z7t9TP5K37sqy5Fkgld1/MGqQe/uGz+6sJzK2vlij7bM4uOm+8VW3VpA3dzs
d5iFmctAd7n5zJ0gXE8rv8Gn6KzL0U/S906ajq3GfdjiC4scO/9Uat7VcfL1wYUTtOMHmvmVq49J
UJZ1/Y7jEWtxRal7XG+DhOveVketmGM51D7E6kDapQ==
=NRqS
-----END PGP SIGNATURE-----

--------------n72mePX18IlQNf7LHvphnPEC--

